IDENTIFICATION DIVISION.
PROGRAM-ID.  SeqWrite.


ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT StudentFile ASSIGN TO "STUDENTS.DAT"
		ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS StudentId
        FILE STATUS IS SupplierStatus.

DATA DIVISION.
FILE SECTION.
FD StudentFile.
01 StudentDetails.
   02  StudentId       PIC 9(7).
   02  StudentName.
       03 Surname      PIC X(8).
       03 Initials     PIC XX.
   02  DateOfBirth.
       03 YOBirth      PIC 9(4).
       03 MOBirth      PIC 9(2).
       03 DOBirth      PIC 9(2).
   02  CourseCode      PIC X(4).
   02  Gender          PIC X.

WORKING-STORAGE SECTION.
01  SupplierStatus             PIC X(2).
01 WS-STUDENT
01 Key2                PIC 9(7).

01 Gender2             PIC X.

PROCEDURE DIVISION.
Begin.
    OPEN OUTPUT StudentFile
    DISPLAY "Enter student details using template below.  Enter no data to end."
    
    MOVE 1234657 TO StudentId
    
    OPEN INPUT StudentFile
    READ StudentFile RECORD INTO WS-STUDENT
         KEY IS StudentId
         INVALID KEY DISPLAY 'Invalid Key'
      END-READ.

    MOVE Gender TO Gender2
    CLOSE StudentFile
    DISPLAY Gender2
    STOP RUN.

GetStudentDetails.
    DISPLAY "Enter - StudId, Surname, Initials, YOB, MOB, DOB, Course, Gender"
    DISPLAY "NNNNNNNSSSSSSSSIIYYYYMMDDCCCCG"
    ACCEPT  StudentDetails.  