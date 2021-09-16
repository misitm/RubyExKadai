require 'dxruby'

class Player < Sprite
  def update
    self.x = [[Input.mouse_x - 16,0].max,Window.width-32].min
    self.y = [[Input.mouse_y - 16,0].max,Window.height-32].min
  end
end

class Enemy < Sprite
  def update(speed)
    self.y += speed
  end
  def hit
    self.vanish
  end
end

player_img = Image.load("image/player.png")
x = 100
y = 100
player = Player.new(x, y, player_img)

enemy_img = Image.load("image/enemy.png")
lines = 4
enemys=Array.new(lines).map{Array.new(20)}
for i in 0..(lines-1) do
  hole=rand(19)
  for j in 0..19 do
    enemys[i][j]=Enemy.new(0, 0, enemy_img)
    if(hole==j||hole+1==j)
      enemys[i][j].x=Window.width+10
      enemys[i][j].y=-120*i
    else
      enemys[i][j].x=j*32
      enemys[i][j].y=-120*i
    end
  end
end
speed=1.5
score=0
font = Font.new(32)

Window.loop do
  player.update
  player.draw
  for i in 0..(lines-1) do
    if enemys[i][0].y>Window.height
      hole=rand(18)
      speed+=0.01
      score+=1
      for j in 0..19 do
        if(hole==j||hole+1==j||hole+2==j)
          enemys[i][j].x=Window.width+10
          enemys[i][j].y=-170
        else
          enemys[i][j].x=j*32
          enemys[i][j].y=-170
        end
      end
    end
    for j in 0..19 do

      enemys[i][j].update(speed)
      enemys[i][j].draw

      if enemys[i][j]===player
        sleep(5)
        Window.close
      end
    end
  end
  Window.draw_font(10, 10, score.to_s, font) 
end
