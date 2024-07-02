#Powered by 小枫_QWQ 2024
Write-Host "程序加载中……"
$player = New-Object System.Media.SoundPlayer
$player.SoundLocation = "$env:windir\Media\Ring05.wav"
$player.Play()
$Version = "0.2.0"
# 主菜单
function ShowMainMenu {
    Clear-Host
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "  欢迎使用 PowerShell小工具箱   "
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "1. 显示当前目录内容"
    Write-Host "2. 切换目录"
    Write-Host "3. 显示当前用户名"
    Write-Host "4. 显示当前日期和时间"
    Write-Host "5. 进行数学运算"
    Write-Host "6. 文件操作"
    Write-Host "7. 游戏菜单"
    Write-Host "q. 退出程序" -ForegroundColor Yellow
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "Powered by 小枫_QWQ   V:$Version" -ForegroundColor Green
}
# 游戏菜单
function ShowGameMainMenu {
    Clear-Host
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "     游 戏 菜 单 | Game-Menu     "
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "1. 猜数字游戏"
    Write-Host "2. 贪吃蛇"
    Write-Host "q. 返回主菜单" -ForegroundColor Yellow
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "            Powered by 小枫_QWQ" -ForegroundColor Green
}
function Pause {
    Write-Output "`n按任意键继续..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    Write-Output ""
}
# 验证数字合法性
function ValidateNumber {
    param([string]$prompt)
    do {
        $inputNumber = Read-Host $prompt
        if (-not [double]::TryParse($inputNumber, [ref]$null)) {
            Write-Host "错误：请输入有效的数字。" -ForegroundColor Red
        }
        else {
            return [double]$inputNumber
        }
    } while ($true)
}
# 主函数
function Main {
    while ($true) {
        ShowMainMenu
        $choice = Read-Host "请输入选项（1-7）"
        switch ($choice) {
            "1" {
                # 显示当前目录内容
                Get-ChildItem
                Pause
                break
            }
            "2" {
                # 切换目录
                $validPath = $false
                while (-not $validPath) {
                    $newPath = Read-Host "请输入要切换的目录路径"
                    if (!$newPath) {
                        Write-Host "不能为空" -ForegroundColor Red
                        $confirm = Read-Host "继续输入目录路径（'q' 返回主菜单）"
                        if ($confirm -eq "q") {
                            break
                        }
                        continue  # 继续下一次循环以重新输入路径
                    }
                    if (Test-Path $newPath -PathType Container) {
                        Set-Location $newPath
                        $validPath = $true
                    }
                    else {
                        Write-Host "目录 '$newPath' 不存在，请重新输入或输入 'q' 返回主菜单。" -ForegroundColor Red
                        $confirm = Read-Host "继续输入目录路径（'q' 返回主菜单）"
                        if ($confirm -eq "q") {
                            break
                        }
                    }
                }
                break
            }
            "3" {
                # 显示当前用户名
                $userName = $env:USERNAME
                Write-Host "当前用户名：$userName" -ForegroundColor Yellow
                Pause
                break
            }
            "4" {
                # 显示当前日期和时间
                $currentDateTime = Get-Date
                Write-Host "当前日期和时间：$currentDateTime" -ForegroundColor Yellow
                Pause
                break
            }
            "5" {
                Clear-Host
                $num1 = ValidateNumber "请输入第一个数字"
                while ($true) {
                    Write-Host "`n选择一个运算符：" -ForegroundColor Green
                    Write-Host "`t+. 加法 (+)"
                    Write-Host "`t-. 减法 (-)"
                    Write-Host "`t*. 乘法 (*)"
                    Write-Host "`t/. 除法 (/)"
                    Write-Host "`tq. 返回主菜单" -ForegroundColor Yellow
                    $operator = Read-Host "请输入你的选择（+, -, *, /, q）"
                    if ($operator -eq 'q') {
                        Write-Host "返回主菜单。" -ForegroundColor Yellow
                        Pause
                        ShowMainMenu
                        break
                    }
                    if ($operator -in @('+', '-', '*', '/')) {
                        $num2 = ValidateNumber "请输入第二个数字"
            
                        switch ($operator) {
                            "+" {
                                $result = $num1 + $num2
                                Write-Host "结果：$result" -ForegroundColor Blue
                            }
                            "-" {
                                $result = $num1 - $num2
                                Write-Host "结果：$result" -ForegroundColor Blue
                            }
                            "*" {
                                $result = $num1 * $num2
                                Write-Host "结果：$result" -ForegroundColor Blue
                            }
                            "/" {
                                if ($num2 -eq 0) {
                                    Write-Host "错误：除数不能为零。" -ForegroundColor Red
                                }
                                else {
                                    $result = $num1 / $num2
                                    Write-Host "结果：$result" -ForegroundColor Blue
                                }
                            }
                        }
                        Pause
                        break
                    }
                    else {
                        Clear-Host
                        Write-Host "无效的输入。请重新输入。" -ForegroundColor Red
                    }
                }
            }
            "6" {
                Clear-Host
                # 文件操作
                Write-Host "`n请选择一个文件操作：" -ForegroundColor Green
                Write-Host "`tnew. 创建新文件"
                Write-Host "`tview. 查看文件内容"
                Write-Host "`tdelete. 删除文件"
                Write-Host "`tq. 返回主菜单" -ForegroundColor Yellow
                $fileOption = Read-Host "请输入你的选择（1/2/3/8）"
                switch ($fileOption) {
                    "new" {
                        $fileName = Read-Host "请输入文件名"
                        $null = New-Item -Path "./$fileName" -ItemType File
                        Write-Host "文件 '$fileName' 已创建。" -ForegroundColor Cyan
                        Pause
                        break
                    }
                    "view" {
                        $fileName = Read-Host "请输入要查看的文件名"
                        if (Test-Path "./$fileName") {
                            $fileContent = Get-Content -Path "./$fileName"
                            Write-Host "文件内容：" -ForegroundColor Yellow
                            Write-Host $fileContent
                            Pause
                        }
                        else {
                            Write-Host "文件 '$fileName' 不存在。" -ForegroundColor Red
                            Pause
                        }
                        break
                    }
                    "delete" {
                        $fileName = Read-Host "请输入要删除的文件名"
                        if (Test-Path "./$fileName") {
                            Remove-Item -Path "./$fileName"
                            Write-Host "文件 '$fileName' 已删除。" -ForegroundColor Cyan
                            Pause
                        }
                        else {
                            Write-Host "文件 '$fileName' 不存在。" -ForegroundColor Red
                            Pause
                        }
                        break
                    }
                    "q" {
                        # 返回主菜单
                        break
                    }
                    default {
                        Write-Host "无效的输入。请重新输入。" -ForegroundColor Red
                        Pause
                        break
                    }
                }
                break
            }
            "7" {
                ShowGameMainMenu
                $choice = Read-Host "请输入选项（1-2）"
                switch ($choice) {
                    "1" {
                        # 猜数字游戏
                        Clear-Host
                        Write-Host "`n=== 猜数字游戏 ===" -ForegroundColor Cyan
                        $correctNumber = Get-Random -Minimum 1 -Maximum 100
                        $guess = 0
                        $attempts = 0
                        do {
                            $guess = Read-Host "猜一个 1 到 100 之间的数字"
                            if ($guess -lt $correctNumber) {
                                Write-Host "太小了，再试一次。" -ForegroundColor Yellow
                            }
                            if ($guess -gt $correctNumber) {
                                Write-Host "太大了，再试一次。" -ForegroundColor Yellow
                            }
                            $attempts++
                        } while ($guess -ne $correctNumber)
                        Write-Host "恭喜你猜对了！正确的数字是 $correctNumber。" -ForegroundColor Green
                        Write-Host "你用了 $attempts 次猜中。" -ForegroundColor Green
                        # 返回主菜单
                        Read-Host "游戏结束..."
                        Pause
                        break
                    }
                    "2" {
                        # 贪吃蛇游戏
                        # Initialize game settings
                        $width = 50
                        $height = 20
                        $snake = New-Object System.Collections.ArrayList
                        $direction = "Right"
                        $global:score = 0
                        # 在游戏内生成随机位置
                        function GetRandomPosition {
                            param (
                                [int]$maxX,
                                [int]$maxY
                            )
                            return [PSCustomObject]@{
                                X = Get-Random -Minimum 1 -Maximum $maxX
                                Y = Get-Random -Minimum 1 -Maximum $maxY
                            }
                        }
                        # 初始化
                        function InitializeGame {
                            $snake.Clear()
                            # Add initial snake position
                            $snake.Add((GetRandomPosition ($width - 1) ($height - 1)))
                            # Set initial food position
                            $global:food = GetRandomPosition ($width - 1) ($height - 1)
                            $global:direction = "Right"
                            $global:score = 0
                        }
                        # 处理用户输入
                        function CheckKeyPress {
                            if ([System.Console]::KeyAvailable) {
                                $key = [System.Console]::ReadKey($true).Key
                                switch ($key) {
                                    'UpArrow' {
                                        $global:lastDirection = "Up"
                                        return "Up"
                                    }
                                    'DownArrow' {
                                        $global:lastDirection = "Down"
                                        return "Down"
                                    }
                                    'LeftArrow' {
                                        $global:lastDirection = "Left"
                                        return "Left"
                                    }
                                    'RightArrow' {
                                        $global:lastDirection = "Right"
                                        return "Right"
                                    }
                                }
                            }
                            return $null
                        }
                        # 更新蛇的位置并检查游戏状态
                        function UpdateGame {
                            param (
                                [string]$direction
                            )
                            # Move snake
                            $newHead = $snake[0]
                            switch ($direction) {
                                "Up" { $newHead.Y-- }
                                "Down" { $newHead.Y++ }
                                "Left" { $newHead.X-- }
                                "Right" { $newHead.X++ }
                            }
                            # Check if the snake head hits the wall
                            if ($newHead.X -eq 0 -or $newHead.X -eq ($width - 1) -or $newHead.Y -eq 0 -or $newHead.Y -eq ($height - 1)) {
                                GameOver
                                return $false
                            }
                            # Check if snake eats food
                            if ($newHead.X -eq $food.X -and $newHead.Y -eq $food.Y) {
                                $global:score++
                                GenerateNewFood
                                $snake.Insert(0, [PSCustomObject]@{ X = $newHead.X; Y = $newHead.Y })
                            }
                            else {
                                $snake.Insert(0, [PSCustomObject]@{ X = $newHead.X; Y = $newHead.Y })
                                $snake.RemoveAt($snake.Count - 1)
                            }
                            return $true
                        }
                        # 绘制游戏画面
                        function ShowGameScreen {
                            $output = @()
                            # ANSI 转义码定义
                            $reset = [char]27 + '[0m'  # 重置样式
                            $cyan = [char]27 + '[36m' # 青色
                            $green = [char]27 + '[32m' # 绿色
                            # 构建游戏界面
                            for ($y = 0; $y -lt $height; $y++) {
                                $line = ""
                                for ($x = 0; $x -lt $width; $x++) {
                                    $char = " "
                                    if ($x -eq 0 -or $x -eq $width - 1 -or $y -eq 0 -or $y -eq $height - 1) {
                                        $char = "#" # 墙壁
                                    }
                                    elseif ($snake[0].X -eq $x -and $snake[0].Y -eq $y) {
                                        $char = "${yellow}O${reset}" # 蛇头，使用黄色圆圈或其他特殊符号表示
                                    }
                                    elseif ($snake | Where-Object { $_.X -eq $x -and $_.Y -eq $y }) {
                                        $char = "${cyan}*${reset}" # 蛇身
                                    }
                                    elseif ($food.X -eq $x -and $food.Y -eq $y) {
                                        $char = "${green}@${reset}" # 食物
                                    }
                                    $line += $char
                                }
                                $output += $line
                            }
                            # 清空并一次性输出，带颜色
                            Clear-Host
                            Write-Host "${cyan}蛇的长度: $($snake.Count) 分数: $score${reset} 使用方向键控制方向"
                            foreach ($line in $output) {
                                Write-Host $line
                            }
                            Write-Host "Powered by 小枫_QWQ @是食物，0是蛇头，*是蛇身体"
                        }
                        # 处理游戏结束
                        function GameOver {
                            Write-Host "游戏结束! 总分: $score" -ForegroundColor Red
                            $choice = Read-Host "是否重新开始或返回主菜单? (Y重新开始/N返回主菜单)"
                            if ($choice -eq "Y" -or $choice -eq "y") {
                                InitializeGame
                            }
                            else {
                                Pause
                                break
                            }
                        }
                        # 生成新的食物位置
                        function GenerateNewFood {
                            do {
                                $global:food = GetRandomPosition ($width - 1) ($height - 1)
                            } while ($snake | Where-Object { $_.X -eq $food.X -and $_.Y -eq $food.Y })
                        }
                        # 主循环
                        InitializeGame
                        # 初始化最后方向为向右（可以根据需要选择任何一个初始方向）
                        $global:lastDirection = "Right"
                        while ($true) {
                            $direction = CheckKeyPress
                            if (-not $direction) {
                                $direction = $global:lastDirection
                            }
                            if (!(UpdateGame -direction $direction)) {
                                continue
                            }
                            ShowGameScreen
                            Start-Sleep -Milliseconds 200
                        }
                        break
                    }
                    "q" {
                        # 直接返回主菜单
                        break  # 跳出循环，回到主菜单处理逻辑
                    }
                    default {
                        Write-Host "无效的输入。请重新输入。" -ForegroundColor Red
                        Pause
                    }
                }
                Break
            }
            "q" {
                # 退出程序
                Write-Host "感谢使用 PowerShell 程序！By！" -ForegroundColor Green
                Pause
                exit
            }
            default {
                Write-Host "无效的选项，请重新输入。" -ForegroundColor Red
                Pause
            }
        }
    }
}
# 启动主函数
Main
#Powered by 小枫_QWQ