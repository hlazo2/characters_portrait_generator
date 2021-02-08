
-- SECTION 01
-- The next variable names could change

-- number of frames that each element of the head have
local pos=5 

-- the directory where the head elements are
local dirProps = "char_parts" 

-- a list orderered of the head elements
-- it will be ordered from first to last to be drawn
local dOrder ={"back_hair", "head", "eyes", "nose", "mouth", "hair", "ears"} 

-- the directory in the filesystem where the images of the head elements are
local imageDir="char_parts/"

-- for the keyboard interface
local keys={"r","x"}

-- message output for the user
local fMessage=""

-- table for the images to be used
local imageList = {}

-- the frames with the variants for each head element layer
local frames = {}

local frameWidth = 256
local frameHeight= 256
local layerWidth = 256*pos
local layerHeight = 256 

-- This function should give a set of random numbers to each layer of the head elements
-- The random number have to be in an interval similar to the number of frames that each
-- head element have. Say the eyes have 5 variants, and the nose also have 5 variants
-- It should have a table of 2 elements, where one have a "1" and the other have a "3"
-- that it will be used for each layer

function listOfRandomNumbers(listOfLayers, variantsOfLayer)
  local t = {}
  for i=1,listOfLayers do
    t[i]= love.math.random(1,variantsOfLayer)
    
  end
  
  return t
end

-- With the random numbers list generated, Now we can generate the quads used to store the position
-- and dimension of the frame that will show the variant in each layer
-- rList is the listOfRandomNumbers; 
-- fw, fh are the width and heigth of the frame
-- lw, lh is the width and the height of the image layer
function listOfQuads(rList, fw, fh, lw, lh)
  local t= {}
  for i=1, #rList do
    t[i] = love.graphics.newQuad(fw*(rList[i]-1),0, fw, fh, lw, lh)
  end
  
  return t
end

function love.load()
  love.graphics.setDefaultFilter( "nearest", "nearest", 1)
  for x=1, #dOrder do
    imageList[x] = love.graphics.newImage(imageDir..dOrder[x]..".png")
  end
  iw, ih= imageList[1]:getDimensions()
  totalOfLayers= #imageList
  frames = listOfQuads(listOfRandomNumbers(#dOrder,pos), frameWidth, frameHeight, layerWidth, layerHeight)
  
  --love.graphics.newQuad(0, 0, 256, 256, iw, ih)
end

function love.keypressed(key)
   for i,v in ipairs(keys) do
      if keys[i] == key then
        fMessage = key.." key" 
        randomPositions = listOfRandomNumbers(totalOfLayers, pos)
        frames = listOfQuads(randomPositions, frameWidth, frameHeight, layerWidth, layerHeight)
        break
      else
        fMessage = key.." not valid"
      end
      
      
    end
  
end



function love.draw()
  
  love.graphics.print("Press 'r' for generate a random character", 500, 300)
  love.graphics.print(fMessage, 500, 400)
  for i=1,#imageList do
   love.graphics.draw(imageList[i], frames[i], 50,50, 0, 1, 1)
  end
 
end

function love.update(dt)
  
end
