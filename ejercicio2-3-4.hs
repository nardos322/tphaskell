-- 2 -- 
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe red us = aux_amigosDe (relaciones red) us

aux_amigosDe :: [Relacion] -> Usuario -> [Usuario]
aux_amigosDe [] _ = []
aux_amigosDe (rel:rels) us | (primero rel) == us = (segundo rel) : (aux_amigosDe rels us)
                           | (segundo rel) == us = (primero rel) : (aux_amigosDe rels us)  -- si ninguno se cumple, es que no era relacion del us -- 
                           | otherwise =  aux_amigosDe rels us 

primero :: (t,t) -> t
primero (x, y) = x

segundo :: (t,t) -> t
segundo (x, y) = y

-- 3 -- 

cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red us  =  longitud (amigosDe (red) us)

-- 4 --

usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos red = buscarUsuarioMax red (x:xs) m 
  where
    (x:xs) = usuarios red 
    m = maximo (listaCantDeAmigos red (x:xs))

buscarUsuarioMax :: RedSocial -> [Usuario] -> Int -> Usuario    
buscarUsuarioMax red (x:xs) m | cantidadDeAmigos red x == m = x     
                              | otherwise = buscarUsuarioMax red xs m

listaCantDeAmigos :: RedSocial -> [Usuario] -> [Int]
listaCantDeAmigos red [] = []  
listaCantDeAmigos red (x:xs) = cantidadDeAmigos red x : listaCantDeAmigos red xs 

maximo :: [Int] -> Int
maximo (x:[]) = x 
maximo (x:xs) | x > head xs = mayor x (maximo xs)
              | otherwise = mayor (head xs) (maximo xs)

mayor :: Int -> Int -> Int 
mayor x y | x >= y = x 
          | otherwise = y 