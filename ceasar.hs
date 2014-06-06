import Data.Array
import System.IO
import System.Environment
import Data.Char
latinLength = length ['a'..'z']
characters = ['a'..'z'] ++ ['A'..'Z'] ++  [' ']
alphaLength = length characters
alphabet = listArray (0,alphaLength) characters
ix ' ' = alphaLength - 1
ix x | x >= 'a' && x <= 'z' = ord x - ord 'a'
ix x | x >= 'A' && x <= 'Z' = latinLength + ord x - ord 'A' 
ix p = error $ [p] ++ " is not in alphabet"
cipher k x = alphabet ! ((ix x + k) `mod` alphaLength)
decipher k y = alphabet ! ((ix y - k + alphaLength) `mod` alphaLength)
usage = "ceasar --help | ceasar -i INPUT_FILE -o OUTPUT_FILE -k KEY (-c|-d)"
help = usage ++"\n-c Зашифровать.\n -d Расшифровать.\n -i Входной файл.\n -o Выходной файл.\n -k Ключ."
main = do
  args <- getArgs
  case args of
    ["--help"] -> putStrLn help
    ["-i", inputFile, "-o", outputFile, "-k", key, chipopt] ->
      do
        str <- readFile inputFile
        case chipopt of
          "-c" -> writeFile outputFile (map (cipher (read key)) str)
          "-d" -> writeFile outputFile (map (decipher (read key)) str)
          _ -> putStrLn usage
    _ -> putStrLn usage
  
