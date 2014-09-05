function Shutdown-COMObject
{
    param(
        [string] $name
    )
    $comAdmin = New-Object -com ("COMAdmin.COMAdminCatalog.1")
    $applications = $comAdmin.GetCollection("Applications")
    $applications.Populate()

    foreach ($application in $applications)
    {

        $components = $applications.GetCollection("Components",$application.key)
        $components.Populate()
        foreach ($component in $components)
        {

            $dllName = $component.Value("DLL")
            $componentName = $component.Name

            "Component Name:$componentName"
            "DllName: $dllName`n"
        }
    }
    $comAdmin.ShutdownApplication($name)
}
