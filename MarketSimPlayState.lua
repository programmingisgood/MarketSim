
local PlayState = { }

local SimpleInput = require("SimpleInput")
local Sound = require("Sound")

require("DebugDrawer")

local kScreenWidth = love.graphics.getWidth()
local kScreenHalfWidth = kScreenWidth / 2
local kScreenHeight = love.graphics.getHeight()
local kScreenHalfHeight = kScreenHeight / 2

local kHugeFont = love.graphics.newFont("art/press-start-2p/PressStart2P.ttf", 62)

local kGridSize = 64

local kCompanyDatabase = { }
-- Corn Farm
local kCornFarm = { }
kCornFarm.type = "CornFarm"
kCornFarm.color = color(100, 100, 0, 255)
kCornFarm.producer = function() return { color = color(200, 200, 0, 255), name = "Corn" } end
kCornFarm.productionRate = 1
kCompanyDatabase[kCornFarm.type] = kCornFarm

local function CreateSprite(path, numRows, numCols)

    local newSprite = { }
    InitMixin(newSprite, MovableMixin)
    InitMixin(newSprite, SpriteMixin)

    newSprite:SetImage(path, numRows, numCols)

    return newSprite

end

local function AddCompany(companies, companyType, xCoord, yCoord)

    local newCompany = { }
    newCompany.type = kCompanyDatabase[companyType]
    newCompany.pos = vec2(xCoord, yCoord)
    table.insert(companies, newCompany)

end

local function Init(self)

    math.randomseed(os.time())

    self.companies = { }
    AddCompany(self.companies, "CornFarm", 2, 1)
    
end

local function OnKeyPressed(self, keyPressed)

    if keyPressed == "escape" then
    
    end
    
end

local function OnKeyReleased(self, keyReleased)
end

local function Update(self, dt)

    

end

local function DrawUI(self)
end

local function DrawWorld(self)

    for c = 1, #self.companies do

        local company = self.companies[c]
        love.graphics.setColor(company.type.color:unpack())
        love.graphics.rectangle("fill", company.pos.x * kGridSize, company.pos.y * kGridSize, kGridSize, kGridSize)

    end

end

local function DrawEntities(self)
end

local function Draw(self)

    love.graphics.setBackgroundColor(180, 180, 180, 255)
    love.graphics.clear()

    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.push()
    
    DrawWorld(self)
    DrawEntities(self)
    
    DebugDrawer.Draw("world")

    love.graphics.pop()

    love.graphics.push()

    DrawUI(self)

    love.graphics.pop()

    DebugDrawer.Draw("screen")

end

local function Create(useFont, client, server)

    local state = { }
    
    state.font = useFont
    state.OnKeyPressed = OnKeyPressed
    state.OnKeyReleased = OnKeyReleased
    state.Update = Update
    state.Draw = Draw
    state.GetBlocksEscape = function() return false end
    Init(state)
    
    return state
    
end

PlayState.Create = Create
return PlayState