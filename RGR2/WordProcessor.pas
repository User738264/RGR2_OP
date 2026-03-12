UNIT WordProcessor;

INTERFACE

FUNCTION IsLetter(C: CHAR): BOOLEAN;
FUNCTION ToLowerChar(C: CHAR): CHAR;
FUNCTION CompareWords(CONST Word1, Word2: STRING): INTEGER;

IMPLEMENTATION

FUNCTION IsLetter(C: CHAR): BOOLEAN;
BEGIN
  IsLetter := ((C >= 'a') AND (C <= 'z')) OR 
              ((C >= 'A') AND (C <= 'Z')) OR
              ((C >= 'À') AND (C <= 'ß')) OR
              (C = '¨') OR (C = '¸') OR
              ((C >= 'à') AND (C <= 'ÿ')) OR
              (C = '-')
END;

FUNCTION ToLowerChar(C: CHAR): CHAR;
BEGIN
  CASE C OF
    'A'..'Z': ToLowerChar := CHR(ORD(C) + 32);
    'À'..'ß': ToLowerChar := CHR(ORD(C) + 32);
    '¨': ToLowerChar := '¸'
  ELSE
    ToLowerChar := C
  END
END;

FUNCTION CompareWords(CONST Word1, Word2: STRING): INTEGER;
VAR
  I, Len1, Len2, MinLen: INTEGER;
  C1, C2: CHAR;
  Res: INTEGER;
BEGIN
  Len1 := LENGTH(Word1);
  Len2 := LENGTH(Word2);
  MinLen := Len1;
  Res := 0;
  
  IF Len2 < MinLen 
  THEN
    MinLen := Len2;

  I := 1;
  WHILE (I <= MinLen) AND (Res = 0) 
  DO
    BEGIN
      C1 := ToLowerChar(Word1[I]);
      C2 := ToLowerChar(Word2[I]);

      // Îáðàáîòêà ¨
      IF C1 = '¸' THEN C1 := Chr(Ord('å') + 1);
      IF C2 = '¸' THEN C2 := Chr(Ord('å') + 1);
      IF C1 = '¨' THEN C1 := Chr(Ord('Å') + 1);
      IF C2 = '¨' THEN C2 := Chr(Ord('Å') + 1);

      IF C1 < C2 
      THEN
        Res := -1
      ELSE 
        IF C1 > C2 
        THEN
          Res := 1;
    
      I := I + 1
    END;

  IF Res = 0 
  THEN
    BEGIN
      IF Len1 < Len2 
      THEN
        Res := -1
      ELSE 
        IF Len1 > Len2 
        THEN
          Res := 1
    END;
  
  CompareWords := Res
END;

BEGIN

END.
