
#use the library Luxor which has functions for us to 'draw' primitive/basic elements onto the screen and save on file
using Luxor


function init()

    
    #basic steps to set up a new image
    newDraw()

    #the high entropy case
    #highEntropy()

    #medium entropy case
    #mediumEntropy()

    #low entropy case
    lowEntropy()

    
    
    finish() 
    preview()

end


#1 box of 12x12
function lowEntropy()
    tiles = Tiler(900, 900, 35, 35, margin=20)
    
    tLcol = rand(7:(35-1))
    tLrow = rand(7:(35-1))
    tL = tLcol + tLrow*(35)
    println(tLcol)
    println(tLrow)
    println(tL)
    
    for (pos, n) in tiles
        if(n==tL)
            println("box draw")
            box(pos,tiles.tilewidth*6, tiles.tileheight*6, :clip)
            background("white")
        end

        clipreset()
    end
    
          
end




#9 different 4x4 pixels non-overlapping placed randomly over the grid
function mediumEntropy()
    tiles = Tiler(900, 900, 35, 35, margin=20)
    
    nAr = zeros(Int,1,9*4)
    avoidNums = zeros(Int,1, 9*4)
    ii=1
    while(ii <= 9*4)
        tL = rand(1:34^2)# 1156
         tLcol = rand(2:(35-1))
    tLrow = rand(2:(35-1))
    tL = tLcol + tLrow*(35)
        tR = tL + 1
        bL = tL + 35
        bR = tL + 35 + 1
        #=
        avoidNums[ii]=(tL)
        avoidNums[ii+1]=(tR)
        avoidNums[ii+2]=(bL)
        avoidNums[ii+3]=(bR)
        =#
        tmp=length(find(avoidNums.==tL))+length(find(avoidNums.==tR))+length(find(avoidNums.==bL))+length(find(avoidNums.==bR))
        if(tmp == 0)
            nAr[ii] = tL
            nAr[ii+1] = tR
            nAr[ii+2] = bL
            nAr[ii+3] = bR
            
            ii = ii + 4
        end
    end
    println(nAr)
    
    for (pos, n) in tiles
        if(length(find(n.==nAr))>0)#n==n1 || n==n2)
            println("box draw")
            box(pos, tiles.tilewidth, tiles.tileheight, :clip)
            background("white")
        end

        clipreset()
    end
    
          
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




