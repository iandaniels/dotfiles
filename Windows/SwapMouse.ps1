$MethodDefinition = @"
    [DllImport("user32.dll")]
    public static extern Int32 SwapMouseButton(Int32 bSwap);
"@

$User32 = Add-Type -MemberDefinition $MethodDefinition -Name 'User32' -Namespace 'Win32' -PassThru

$User32::SwapMouseButton(1)