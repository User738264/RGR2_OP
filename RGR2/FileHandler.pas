UNIT FileHandler;

INTERFACE

USES
  WordProcessor, TreeProcessor;

PROCEDURE ProcessLargeFile(VAR InputFile: TEXT);
PROCEDURE SaveStatistics(VAR OutputFile: TEXT);

IMPLEMENTATION

PROCEDURE ProcessLargeFile(VAR InputFile: TEXT);
VAR
  Line: STRING;
  CurrentWord: STRING;
  I: INTEGER;
BEGIN
  CurrentWord := '';
  RESET(InputFile);

  WHILE NOT EOF(InputFile) 
  DO
    BEGIN
      READLN(InputFile, Line);
      IF (LENGTH(CurrentWord) > 0)
      THEN
        BEGIN
          TreeProcessor.InsertIntoStructure(CurrentWord);
          CurrentWord := ''
        END;
      FOR I := 1 TO LENGTH(Line) 
      DO
        BEGIN
          IF WordProcessor.IsLetter(Line[I]) 
          THEN
            CurrentWord := CurrentWord + Line[I]
          ELSE 
            IF (LENGTH(CurrentWord) > 0)
            THEN
              BEGIN
                TreeProcessor.InsertIntoStructure(CurrentWord);
                CurrentWord := ''
              END
        END
    END;

  IF LENGTH(CurrentWord) > 0 
  THEN
    TreeProcessor.InsertIntoStructure(CurrentWord);

  CLOSE(InputFile)
END;

PROCEDURE SaveStatistics(VAR OutputFile: TEXT);
BEGIN
  REWRITE(OutputFile);
  
  TreeProcessor.SaveStructureToFile(OutputFile);
  TreeProcessor.FreeStructure();
  CLOSE(OutputFile)
END;

BEGIN

END.
