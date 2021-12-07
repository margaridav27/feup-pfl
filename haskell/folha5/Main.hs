module Main

import f5

main:: IO()
main do
        str <- getline
        print (calcular str)
