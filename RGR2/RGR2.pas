PROGRAM CountWords(INPUT, OUTPUT);

USES
  FileHandler;

VAR
  InputFileName, OutputFileName: STRING;
  InputFile, OutputFile: TEXT;

BEGIN
  WRITE('Введите имя входного файла: ');
  READLN(InputFileName);
  WRITE('Введите имя выходного файла: ');
  READLN(OutputFileName);
  // защита read-а
  IF (LENGTH(InputFileName) > 0) AND (LENGTH(OutputFileName) > 0)
  THEN
    BEGIN
      ASSIGN(InputFile, InputFileName);
      ASSIGN(OutputFile, OutputFileName);
      ProcessLargeFile(InputFile);
      SaveStatistics(OutputFile);
      WRITELN('Обработка завершена. Результат сохранен в ', OutputFileName)
    END
END.
