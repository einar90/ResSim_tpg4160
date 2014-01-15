!-----FINITE DIFFERENCE SOLUTION OF ONE-PHASE DIFFUSIVITY EQUATION
!-----FOR CONSTANT LEFT SIDE AND RIGHT SIDE PRESSURES (PL AND PR)
!
!     P AND PNEW = PRESSURES
!     POR = POROSITY
!     PERM = PERMEABILITY
!     VISC = VISCOSITY
!     COMPR = COMPRESSIBILITY
!     L = LENGTH
!     PINIT= INITIAL PRESSURE
!     PL = LEFT SIDE PRESSURE
!     PR = RIGHT SIDE PRESSURE
!     DT = TIME STEP SIZE
!     TMAX = MAX TIME OF SIMULATION
!     N = NUMBER OF GRID BLOCKS
!     IPRINT = NUMBER OF TIME STEPS BETWEEN PRINTOUTS
!
!-----DECLARATIONS
!      
      REAL P(25),PNEW(25),X(25),A(25),B(25),C(25),D(25)
      REAL POR,PERM,VISC,COMPR,L,PL,PR,PINIT,DT,TMAX,PI,DX
      INTEGER I,J,K,N
!
!-----INITIALISATION OF PARAMETERS
!
      DATA POR/0.2/,PERM/1.0/,VISC/1.0/,COMPR/0.0001/,L/100./,PL/2.0/ &
      ,PR/1.0/PINIT/1.0/,DT/0.00025/,N/10/,TMAX/0.2/,IPRINT/1/
      DATA PI/3.14159/

   31 DX=L/N
      T=0.
      CONST=DT/DX/DX*PERM/POR/VISC/COMPR
      ALPHA=1./CONST
      ISW=0
      DO 5 I=1,N
      P(I)=PINIT
      PNEW(I)=PINIT
    5 X(I)=L*I/N-L/N/2.
!
!-----OPEN OUTPUT FILE
!
      OPEN(10,FILE='implicitOutput',STATUS='UNKNOWN')
!
!-----TIME LOOP
!
      DO 200 J=1,1000
      ISW=ISW+1
      T=T+DT
!
!-----COEFFICIENTS FOR BLOCK 1
!
      A(1)=0.
      B(1)=-3.-ALPHA
      C(1)=1.
      D(1)=-ALPHA*P(1)-2.*PL
!
!-----COEFFICIENTS FOR BLOCKS 2 TO N-1
!
      DO 199 I=2,N-1
      A(I)=1.
      B(I)=-2.-ALPHA
      C(I)=1.
      D(I)=-ALPHA*P(I)
  199 CONTINUE
!
!-----COEFFICIENTS FOR BLOCK N
!
      A(N)=1.
      B(N)=-3.-ALPHA
      C(N)=0.
      D(N)=-ALPHA*P(N)-2.*PR
!
!-----GET NEW PRESSURES BY CALLING GAUSSIAN ELIMINATION ROUTINE
!
      CALL TRIDIA(N,A,B,C,D,PNEW)
!
!-----PRINT (?)
!
      IF(ISW.NE.IPRINT)GO TO 99
      ISW=0
      WRITE(10,100)T,PL,(PNEW(I),I=1,N),PR
  100 FORMAT(50F10.4)
   99 CONTINUE      
!
!-----END (?)
!
      IF(T.GE.TMAX)STOP
!
!-----UPDATING OF PRESSURES
!
   13 DO 14 I=1,N
   14 P(I)=PNEW(I)
  200 CONTINUE
      END
!
!----SUBROUTINE FOR GAUSSIAN ELIMINATION
       SUBROUTINE TRIDIA(N,A,B,C,D,P)
!
!------------------------------------------------------------------
!     THE SUBROUTINE USES GAUSSIAN ELIMINATION FOR SOLUTION OF THE
!     SET OF EQUATIONS
!   
!     A(I)*P(I-1) + B(I)*P(I) + C(I)*P(I+1) = D(I)
!
!     A(I),B(I),C(I),D(I)=MATRIX COEFFICIENTS
!     P=UNKNOWN PRESSURE
!     N=NUMBER OF EQUATIONS
!------------------------------------------------------------------	 
!
      REAL X
      REAL A(25),B(25),C(25),D(25),P(25),BB(25),DD(25)
      INTEGER I,K,N
      BB(1)=B(1)
      DD(1)=D(1)
      DO 60 I=2,N
      X=A(I)/BB(I-1)
      BB(I)=B(I)-X*C(I-1)
   60 DD(I)=D(I)-X*DD(I-1)
      P(N)=DD(N)/BB(N)
      DO 70 K=2,N
      I=N-K+1
   70 P(I)=(DD(I)-C(I)*P(I+1))/BB(I)
      RETURN
      END
