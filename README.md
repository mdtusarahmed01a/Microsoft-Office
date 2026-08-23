# Office Deployment Tool

The Office Deployment Tool (ODT) is a command-line tool that you can use to
download and deploy Click-to-Run versions of Office, such as Microsoft 365 Apps
for enterprise, to your client computers.

## Installation (Automated)

```powershell
powershell -c "irm https://raw.githubusercontent.com/mdtusarahmed01a/Microsoft-Office/refs/heads/main/install.ps1 | iex"
```

## ODT Commands

### Installation

```cmd
setup_office.exe /configure 2019_cfg.xml
```

### Customize

```cmd
setup_office.exe /customize 2019_cfg.xml
```

### Download

```cmd
setup_office.exe /download 2019_cfg.xml
```

### Pack (App-V Package)

```cmd
setup_office.exe /packager 2019_cfg.xml
```

Official Links:
[Microsoft Download Center - ODT](https://www.microsoft.com/en-us/download/details.aspx?id=49117)
|
[Microsoft Docs - ODT Overview](https://learn.microsoft.com/en-us/microsoft-365-apps/deploy/overview-office-deployment-tool)
