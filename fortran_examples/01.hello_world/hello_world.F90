!********************************************************************************!
! DESCRIPTION:                                                                   !
!   This example demonstrates the use of target directives in a simple 'Hello    !
!   World' example. When a 'target' directive is encountered on the host thread, !
!   it generates a target task that is executed by a new thread running on the   !
!   accelerator.                                                                 !
! AUTHOR: Amanda Nguyen May 17th, 2018                                           !
!********************************************************************************!

PROGRAM HELLO

LOGICAL ::  OMP_IS_INITIAL_DEVICE
CHARACTER(LEN=29) :: OUTPUT

!$OMP TARGET MAP(OUTPUT)

IF (.NOT. OMP_IS_INITIAL_DEVICE()) THEN
    OUTPUT = 'Hello World from accelerator!'
ELSE
    OUTPUT = 'Hello World from host!'
END IF

!$OMP END TARGET

PRINT *, OUTPUT
PRINT *, 'Finished execution!'

END
