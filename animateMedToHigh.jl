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
    

    animate(demo, [
    Scene(demo, backdrop, 0:100),
    Scene(demo, mediumEntropy, 0:100)
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
        if( !(isempty(find(n.==NN))) )
            background("white")
        else
            background("red")
        end
        clipreset()
    end
    
end
###
#9 different 4x4 pixels non-overlapping placed randomly over the grid
function mediumEntropy(scene, framenumber)
    tiles = Tiler(900, 900, 35, 35, margin=20)
    NN = []
    numTotal = 3^2
    tileNumTotal = 35^2
    NNfull = collect(1:tileNumTotal)
    NNq = []
    #
    for ii in 1:maximum(NNfull)
        if( mod(ii,35)==0 || mod(ii+1,35)==0 || mod(ii+2,35)==0)# || mod(ii,35-2)==0 || mod(ii,35-3)==0 || mod(ii,35-4)==0)
            append!(NNq,ii)
            deleteat!(NNfull,findin(NNfull,ii))        
        elseif( ii > (35-3)*35 )
            append!(NNq,ii)
            deleteat!(NNfull,findin(NNfull,ii))
        end
        
    end
    #
    
    #for bb in 1:numTotal
    bb=1
    while(bb <= numTotal)
        n1 = sample(NNfull,1,replace=false)[1]
#        print(string("type=",typeof(n1)," , mod(n1,35)=",mod(n1,35)," , mod(n1+1,35)=",mod(n1+1,35)," , mod(n1+2,35)=",mod(n1+2,35)))
#        println(" , n1 value=",n1)
        #if( (mod(n1,35)==0 || mod(n1+1,35)==0 || mod(n1+2,35)==0) )
        #    println("on edge")
        #    continue
        #else
            
            for ii in 1:4
                for jj in 1:4
                    tmp = n1  + ii - 1  + (jj-1)*35
                    append!(NN,tmp)#append!(NN,tmp)
                    deleteat!(NNfull,findin(NNfull,tmp)) 
                end    
            end
            #prohibited rim
            n2 = n1 - 3 - (35*3)
            for ii in 1:8
                for jj in 1:8
                    tmp = n2 + ii - 2 + (jj-1)*35
                    append!(NNq,tmp)
                    deleteat!(NNfull,findin(NNfull,tmp)) 
                end    
            end
            bb += 1
        #end
    end
    
   
    for (pos, n) in tiles
        box(pos, tiles.tilewidth, tiles.tileheight, :clip)
        if(  !(isempty(find(n.==NN)))  )            
            background("red")
        elseif(  !(isempty(find(n.==NNq)))  )            
            background("white")
        else
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
=#

