#=
al062959@cosd4vgzc2:/tmp/tmpMvSH80$ display example.gif al062959@cosd4vgzc2:/tmp/tmpMvSH80$ cd ..
al062959@cosd4vgzc2:/tmp$ cd tmpZWvrDF/
al062959@cosd4vgzc2:/tmp/tmpZWvrDF$ convert -delay 1 -loop 0 *.png example.gifal062959@cosd4vgzc2:/tmp/tmpZWvrDF$ display example.gif 
=#
#use the library Luxor which has functions for us to 'draw' primitive/basic elements onto the screen and save on file
using Luxor
using Distributions

function initAni1()
    demo = Movie(1000, 1000, "testLow")   
    #the high entropy case
    #highEntropy()
    #medium entropy case
    #mediumEntropy()
    #low entropy case
#   lowEntropy()

    animate(demo, [
    Scene(demo, backdrop, 0:100),
    Scene(demo, lowEntropy, 0:100)
    ],
    creategif=true, pathname="/home/al062959/Documents/repos/entropyEEG/expert.gif")
    
end

function backdrop(scene, framenumber)
    background("black")
end

#1 box of 12x12
function lowEntropy(scene, framenumber)
    tiles = Tiler(900, 900, 35, 35, margin=20)

    NN=[]
    tLcol = rand(1:(35-12))
    tLrow = rand(1:(35-12))
    tLrowInd = 1 + (tLrow-1)*35
    
    for ii in 1:12
        for jj in 1:12
            tmp = tLrowInd + tLcol + ii - 2  + (jj-1)*35
            append!(NN,tmp)
        end
        
    end

    
    for (pos, n) in tiles
        box(pos,tiles.tilewidth, tiles.tileheight, :clip)
        if( n == tLcol || n == tLrowInd  || !(isempty(find(n.==NN))) )
            background("white")
        else
            background("red")
        end
        clipreset()
    end
    
end
###
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


####################
#the high entropy case
function highEntropy(scene, framenumber)
    #Luxor function to make tiles/cells/matrix/grid of the 900by900 image with 35x35 blocks
    #the return from this function allows us to iterate over the tiles for the position and number
    tiles = Tiler(900, 900, 35, 35, margin=20)

    #how many independently drawn boxes
    numTotal = 12^2
    tileNumTotal = 35^2
    #sample the tiles which will be colored
    tileInds = sample(1:tileNumTotal,numTotal,replace=false)
  
    #'pos' is the center of the tile as a Point object
    #'n' is the number of the tiles in the Tiler object for the grid we requested
    for (pos, n) in tiles
        box(pos, tiles.tilewidth, tiles.tileheight, :clip)
        
        if( isempty( find( n .== tileInds ) ))
            background("red")
        else
            background("white")
        end
        
        clipreset()
    end
end




#=
#the high entropy case logic for each cell
function randomGrid()
    #set the square to be black or white
    if(rand() > 0.5)
        background("white")
    else
        background("red")
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

=#

