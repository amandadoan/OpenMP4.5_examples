!*****************************************************************************!
! DESCRIPTION:                                                                !
!   This program is the OpenMP version of a dot product that highlights       !
!   the target, map, and reduction directives. Also serves as an example of   !
!   combined and composite accelerated worksharing constructs (Using OpenMP:  !
!   the Next Steps p. 283). Recall that a variable cannot appear in both a    !
!   map clause and a data-sharing atribute clause on the same construct.      !
! AUTHOR: Amanda Nguyen May 22nd 2018                                         !
!******************************************************************************

program dotproduct

! Define length of dot product vectors and number of OpenMP threads 
      integer VECLEN, NUMTHREADS
      parameter(VECLEN=100)
      parameter(NUMTHREADS=8)

      integer i, tid, OMP_GET_THREAD_NUM
      real*8 a(VECLEN*NUMTHREADS), b(VECLEN*NUMTHREADS), sum, psum

      print *, 'Starting omp_dotprod_openmp. Using', NUMTHREADS,
     &         ' threads'

! Initialize dot product vectors 
      do i=1, VECLEN*NUMTHREADS
        a(i)=1.0
        b(i)=a(i)
      end do 
! Initialize global sum
      sum = 0.0

! Perform the dot product in an OpenMP parallel region for loop with a sum reduction
! For illustration purposes:
!   - Explicitly sets number of threads
!   - Each thread keeps track of its partial sum

!$OMP PARALLEL PRIVATE(i,tid,psum) NUM_THREADS(NUMTHREADS)
      psum = 0.0
      tid = OMP_GET_THREAD_NUM()

!$OMP DO REDUCTION(+:sum)
      do i=1, VECLEN*NUMTHREADS
        sum = sum + a(i) * b(i)
        psum = sum
      end do
!$OMP END DO
      print *, 'Thread',tid,' partial sum =',psum
!$OMP END PARALLEL

      print *, 'Done. OpenMP version: sum  =', sum

end
