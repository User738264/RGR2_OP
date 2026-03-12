UNIT TreeProcessor;

INTERFACE

USES
  WordProcessor;
  
TYPE
  PWordNode = ^TWordNode;
  TWordNode = RECORD
    Word: STRING;
    Count: INTEGER;
    Left, Right: PWordNode
  END;

VAR
  WordTree: PWordNode;

PROCEDURE InsertIntoStructure(CONST Word: STRING);
PROCEDURE FreeStructure();
PROCEDURE SaveStructureToFile(VAR OutputFile: TEXT);
PROCEDURE AddWordToTree(VAR Root: PWordNode; CONST Word: STRING);
PROCEDURE FreeWordTree(VAR Root: PWordNode);
PROCEDURE TraverseTree(Root: PWordNode; VAR OutputFile: TEXT);

IMPLEMENTATION

PROCEDURE InsertIntoStructure(CONST Word: STRING);
BEGIN
  AddWordToTree(WordTree, Word)
END;

PROCEDURE FreeStructure();
BEGIN
  FreeWordTree(WordTree)
END;

PROCEDURE SaveStructureToFile(VAR OutputFile: TEXT);
BEGIN
  TraverseTree(WordTree, OutputFile)
END;

PROCEDURE AddWordToTree(VAR Root: PWordNode; CONST Word: STRING);
VAR
  LowerWord: STRING;
  I: INTEGER;
  Cmp: INTEGER;
BEGIN
  IF Word <> '' 
  THEN
  BEGIN
    SETLENGTH(LowerWord, LENGTH(Word));
    FOR I := 1 TO LENGTH(Word) 
    DO
      LowerWord[I] := WordProcessor.ToLowerChar(Word[I]);

    IF Root = NIL 
    THEN
      BEGIN
        NEW(Root);
        Root^.Word := LowerWord;
        Root^.Count := 1;
        Root^.Left := NIL;
        Root^.Right := NIL
      END
    ELSE
      BEGIN
        Cmp := WordProcessor.CompareWords(Root^.Word, LowerWord);
    
        IF Cmp = 0 
        THEN
          INC(Root^.Count)
        ELSE 
          IF Cmp > 0 
          THEN
            AddWordToTree(Root^.Left, LowerWord)
          ELSE
            AddWordToTree(Root^.Right, LowerWord)
      END
  END
END;

PROCEDURE FreeWordTree(VAR Root: PWordNode);
BEGIN
  IF Root <> NIL 
  THEN
    BEGIN
      FreeWordTree(Root^.Left);
      FreeWordTree(Root^.Right);
      DISPOSE(Root);
      Root := NIL
    END
END;

PROCEDURE TraverseTree(Root: PWordNode; VAR OutputFile: TEXT);
BEGIN
  IF Root <> NIL 
  THEN
    BEGIN
      TraverseTree(Root^.Left, OutputFile);
      WRITELN(OutputFile, Root^.Word, ' ', Root^.Count);
      TraverseTree(Root^.Right, OutputFile)
    END
END;

BEGIN
  WordTree := NIL
END.
