using Godot;
using System;

/// <summary>
/// Represents an enemy character in the game.
/// </summary>

/// public partial class enemy : CharacterBody2D
{
	private Player player;
private Area2D area;

// Called when the node enters the scene tree for the first time.
public override void _Ready()
{
	player = GetNode<Player>("../Player");
	area = GetNode<Area2D>("Area2D"); // Substitua "Area2D" pelo caminho para o seu Area2D
	area.Connect("body_entered", new Callable(this, nameof(OnBodyEntered)));
}

// Called every frame. 'delta' is the elapsed time since the previous frame.
public override void _Process(double delta)
{
	LookAt(player.GlobalPosition);
}

/// <summary>
/// Called when a body enters the enemy's collision detection area.
/// </summary>
/// <param name="body">The body that entered the area.</param>
public void OnBodyEntered(Node body)
{
	// If the entered body is the player, make the player take damage.
	if (body == player)
	{
		player.TakeDamage(10); // Substitua 10 pelo valor de dano que você deseja
	}
}
}