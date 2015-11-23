MODULE utilities

  USE constants

  IMPLICIT NONE

  INTERFACE grow_array
    MODULE PROCEDURE grow_real_array, grow_integer_array, grow_string_array
  END INTERFACE grow_array

  PRIVATE :: grow_real_array, grow_integer_array, grow_string_array

CONTAINS

  SUBROUTINE grow_real_array(array, idx)

    REAL(num), DIMENSION(:), POINTER :: array
    INTEGER, INTENT(IN) :: idx
    REAL(num), DIMENSION(:), ALLOCATABLE :: tmp_array
    INTEGER :: old_size, new_size, i

    old_size = SIZE(array)
    IF (idx <= old_size) RETURN

    ALLOCATE(tmp_array(old_size))
    DO i = 1, old_size
      tmp_array(i) = array(i)
    ENDDO

    new_size = 2 * old_size
    DEALLOCATE(array)
    ALLOCATE(array(new_size))

    DO i = 1, old_size
      array(i) = tmp_array(i)
    ENDDO

    DEALLOCATE(tmp_array)

  END SUBROUTINE grow_real_array



  SUBROUTINE grow_integer_array(array, idx)

    INTEGER, DIMENSION(:), POINTER :: array
    INTEGER, INTENT(IN) :: idx
    INTEGER, DIMENSION(:), ALLOCATABLE :: tmp_array
    INTEGER :: old_size, new_size, i

    old_size = SIZE(array)
    IF (idx <= old_size) RETURN

    ALLOCATE(tmp_array(old_size))
    DO i = 1, old_size
      tmp_array(i) = array(i)
    ENDDO

    new_size = 2 * old_size
    DEALLOCATE(array)
    ALLOCATE(array(new_size))

    DO i = 1, old_size
      array(i) = tmp_array(i)
    ENDDO

    DEALLOCATE(tmp_array)

  END SUBROUTINE grow_integer_array



  SUBROUTINE grow_string_array(array, idx)

    CHARACTER(LEN=string_length), DIMENSION(:), POINTER :: array
    INTEGER, INTENT(IN) :: idx
    CHARACTER(LEN=string_length), DIMENSION(:), ALLOCATABLE :: tmp_array
    INTEGER :: old_size, new_size, i

    old_size = SIZE(array)
    IF (idx <= old_size) RETURN

    ALLOCATE(tmp_array(old_size))
    DO i = 1, old_size
      tmp_array(i) = array(i)
    ENDDO

    new_size = 2 * old_size
    DEALLOCATE(array)
    ALLOCATE(array(new_size))

    DO i = 1, old_size
      array(i) = tmp_array(i)
    ENDDO

    DEALLOCATE(tmp_array)

  END SUBROUTINE grow_string_array



  SUBROUTINE abort_code(errcode)

    USE mpi

    INTEGER, INTENT(IN) :: errcode
    INTEGER :: i, newcode, ierr

    ! Translate error code bitmask into 0-255 range.
    ! Only the lowest bit is kept
    newcode = errcode
    DO i = 0, 255
      IF (newcode == 0) THEN
        newcode = i
        EXIT
      ENDIF
      newcode = newcode / 2
    ENDDO

    CALL MPI_ABORT(MPI_COMM_WORLD, newcode, ierr)

  END SUBROUTINE abort_code

END MODULE utilities
