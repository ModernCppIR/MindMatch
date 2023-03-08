var bar ;
var particle_no = 25 ;
var counter = 0;
var Particles = [];
var ctx ;
var backgoundWidth,backgroundHeight ;
var width = 350;
var height = 25;
var x = 25;
var y = 80;
var particleColor = "white"

function setBar(value){
	bar = value
}

function setSizes(width , height)
{
	backgoundWidth = width;
	backgroundHeight = height;
}

function setCtx(value) {

	ctx = value;
}

function reset()
{
	ctx.clearRect(0, 0, backgoundWidth, backgroundHeight);
}

function Progressbar()
{
	this.widths = 0;
	this.hue = 0;

	this.draw = function()
	{
	}
}

function Particle()
{
	this.x = x + bar.widths;
	this.y = y;

	this.vx = 0.8 + Math.random() * 1;
	this.v = Math.random() * 5;
	this.g = 1 + Math.random() * 3;
	this.down = false;
	var size = Math.random() * 3;
	this.draw = function()
	{
		ctx.fillStyle = particleColor;
		ctx.fillRect(this.x, this.y, size, size);
	}
}



function draw()
{
	reset();
	counter++;

	bar.hue += 0.8;

	bar.widths += 2;

	if (bar.widths > width)
	{
		reset()
	}
	else
	{
		bar.draw();
		for (var i = 0; i < particle_no; i += 10)
		{
			Particles.push(new Particle());
		}
	}

	update();
}

function update()
{
	for (var i = 0; i < Particles.length; i++)
	{
		var p = Particles[i];
		p.x -= p.vx;

		if (p.down == true)
		{
			p.g += 0.1;
			p.y += p.g;
		}
		else
		{
			if (p.g < 0)
			{
				p.down = true;
				p.g += 0.1;
				p.y += p.g;
			}
			else
			{
				p.y -= p.g;
				p.g -= 0.1;
			}
		}

		p.draw();
	}
}

