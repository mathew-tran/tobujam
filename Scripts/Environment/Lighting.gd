extends CanvasModulate

func _ready():
	Game.connect("StartTrading", Callable(self, "OnStartTrading"))

func OnStartTrading():
	color = "003eda"
