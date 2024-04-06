using Godot;

/// <summary>
/// Represents a player character in the game.
/// </summary>

public partial class Player : CharacterBody2D
{
    [Export]
    public int Speed { get; set; } = 400;

    [Export]
    public int Health { get; set; } = 100;
    public int Damage { get; set; } = 10;

    private Vector2 inertia = new Vector2();

    private const float MaxInertia = 12f;
    private const float InertiaFraction = 0.1f;

    private Label healthLabel;

    /// <summary>
    /// Gets the player's input and updates the player's velocity and inertia.
    /// </summary>
    public void GetInput()
    {
        if (Health <= 0)
        {
            return;
        }

        LookAt(GetGlobalMousePosition());
        var input = Transform.X * Input.GetAxis("down", "up") * Speed;
        Velocity = input;
        inertia += input * InertiaFraction;
    }

    /// <summary>
    /// Reduces the player's health by the specified amount and updates the health label.
    /// </summary>
    /// <param name="damage">The amount of damage to be taken.</param>
    public void TakeDamage(int damage)
    {
        if (Health <= 0)
        {
            Die();
            return;
        }
        Health -= damage;


        // Update the label whenever the health changes
        healthLabel.Text = "Health: " + Health;

    }

    /// <summary>
    /// Handles the player's death.
    /// </summary>
    public void Die()
    {
        // TODO: Implement death logic

        healthLabel.Text = "You died!";

    }

    public override void _Ready()
    {
        healthLabel = GetNode<Label>("/root/World/HealthLabel");
        // Update the label whenever the health changes
        healthLabel.Text = "Health: " + Health;
    }

    public override void _PhysicsProcess(double delta)
    {
        GetInput();
        if (inertia.Length() > MaxInertia)
        {
            inertia = inertia.Normalized() * MaxInertia;
        }
        Velocity += inertia;
        MoveAndSlide();
    }
}