
#use the library Luxor which has functions for us to 'draw' primitive/basic elements onto the screen and save on file
using Luxor


function init()

    #basic steps to set up a new image
    newDraw()

    #the high entropy case
    highEntropy()
   
    finish() 
    preview()

end

#basic steps to set up a new image
function newDraw()
    #set the window size and output image of the function
    Drawing(1000, 1000,"entropyEEG.png")
    #function to make an origin for the image in the 'center' of the drawing window
    origin()
    
    #default black background
    background("black")

end






#the high entropy case
function highEntropy()
    #Luxor function to make tiles/cells/matrix/grid of the 900by900 image with 35x35 blocks
    #the return from this function allows us to iterate over the tiles for the position and number
    tiles = Tiler(900, 900, 35, 35, margin=20)
    
    #'pos' is the center of the tile as a Point object
    #'n' is the number of the tiles in the Tiler object for the grid we requested
    for (pos, n) in tiles
        
        #draw a box, with the width and height of the tile, and the pos at the center, put the clip as the boundary
        box(pos, tiles.tilewidth, tiles.tileheight, :clip)
        #background(randomhue()...)
        
        randomGrid()
        #needed to 
        clipreset()
    end
end

#the high entropy case logic for each cell
function randomGrid()
    #set the square to be black or white
    if(rand() > 0.5)
        background("white")
    else
        background("black")
    end
    
end




