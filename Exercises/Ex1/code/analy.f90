PROGRAM ANALYTICAL 

!-----------------
!-----DECLARATIONS
!-----------------
REAL P(25),PNEW(25),X(25),A(25),B(25),C(25),D(25)
REAL POR,PERM,VISC,COMPR,L,PL,PR,PINIT,DT,TMAX,PI,DX
INTEGER I,J,K,ISW,N


!---------------------------------
!-----INITIALISATION OF PARAMETERS
!---------------------------------
POR=0.2
PERM=1.0
VISC=1.0
COMPR=0.0001
L=100
PL=2.0
PR=1.0
PINIT=1.0
DT=0.00025
N=10
TMAX=0.2
IPRINT=1
PI=3.14159

DX=L/N
T=0.
CONST=DT/DX/DX*PERM/POR/VISC/COMPR
ALPHA=1./CONST
ISW=0
DO I=1,N
  P(I)=PINIT
  PNEW(I)=PINIT
  X(I)=L*I/N-L/N/2.
END DO


! OPEN OUTPUT FILE
OPEN(10,FILE='analyticalOutput',STATUS='UNKNOWN')


! TIME LOOP
DO J=1,1000
  ISW=ISW+1
  T=T+DT

  ! ANALYTICAL SOLUTION
  DO I=1,N
    PNEW(I)=PL+(PR-PL)*X(I)/L
    DO K=1,1000
      DP=(PR-PL)*2./PI/K*EXP(-PI*PI*K*K/L/L*PERM*T/POR/VISC/COMPR) &
      *SIN(X(I)*K*PI/L)
      PNEW(I)=PNEW(I)+DP
      IF(K.GT.10.AND.ABS(DP).LT.0.0000001) EXIT
    END DO ! end inner analytical sol. loop
  END DO ! end outer analytical sol. loop     

  ! PRINT (?)
  IF(ISW.EQ.IPRINT) THEN
    ISW=0
    WRITE(10,100)T,PL,(PNEW(I),I=1,N),PR
    100 FORMAT(50F10.4)
  END IF ! end print if

  ! END (?)
  IF(T.GE.TMAX)STOP

  ! UPDATING OF PRESSURES
  DO I=1,N
    P(I)=PNEW(I)
  END DO ! end updating pressure loop

END DO ! end time loop

END PROGRAM

