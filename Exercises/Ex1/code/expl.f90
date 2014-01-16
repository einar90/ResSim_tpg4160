PROGRAM EXPLICIT

!DECLARATIONS
REAL P(25),PNEW(25),X(25),A(25),B(25),C(25),D(25)
REAL POR,PERM,VISC,COMPR,L,PL,PR,PINIT,DT,TMAX,PI,DX

!INITIALISATION OF PARAMETERS
DATA POR/0.2/,PERM/1.0/,VISC/1.0/,COMPR/0.0001/,L/100./,PL/2.0/ &
,PR/1.0/PINIT/1.0/,DT/0.00025/,N/10/,TMAX/0.2/,IPRINT/1/
INTEGER ISW,I,N,J
DATA PI/3.14159/

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

!-----OPEN OUTPUT FILE
OPEN(10,FILE='explicitOutput',STATUS='UNKNOWN')

!-----TIME LOOP
DO J=1,1000
  ISW=ISW+1
  T=T+DT

  !EXPLICIT SOLUTION
  PNEW(1)=P(1)+CONST*(P(2)-3.0*P(1)+2.0*PL)
  PNEW(N)=P(N)+CONST*(2.0*PR-3.0*P(N)+P(N-1))
  DO I=2,N-1
    PNEW(I)=P(I)+CONST*(P(I+1)-2.0*P(I)+P(I-1))
  END DO

  !PRINT (?)
  IF(ISW.EQ.IPRINT) THEN
    ISW=0
    WRITE(10,100)T,PL,(PNEW(I),I=1,N),PR
    100 FORMAT(50F10.4)
  END IF

  !END (?)
  IF(T.GE.TMAX)STOP

  !UPDATING OF PRESSURES
  DO I=1,N
    P(I)=PNEW(I)
  END DO
END DO

END PROGRAM