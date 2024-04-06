using Godot;

public partial class Player : CharacterBody2D
{
    [Export]
    public int Speed { get; set; } = 400;

    private Vector2 inertia = new Vector2();

    private const float MaxInertia = 12f;
    private const float InertiaFraction = 0.1f;

    public void GetInput()
    {
        LookAt(GetGlobalMousePosition());
        var input = Transform.X * Input.GetAxis("down", "up") * Speed;
        Velocity = input;
        inertia += input * InertiaFraction;
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