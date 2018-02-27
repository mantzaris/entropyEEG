

using Luxor

Drawing(1000, 1000,"entropyEEG.png")
origin()

background("black")


tiles = Tiler(900, 900, 35, 35, margin=20)

for (pos, n) in tiles
    
    box(pos, tiles.tilewidth, tiles.tileheight, :clip)
    #background(randomhue()...)
    if(rand() > 0.5)
        background("white")
    else
        background("black")
    end
    
   #sethue("white")
    clipreset()
end


finish()
preview()
