//
//  TimeManager.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI
import WidgetKit


class TimeManager: ObservableObject {
    // MARK: - Picker設定
    //Pickerで設定した"時間"を格納する変数
    @Published var hourSelection: Int = 1
    //Pickerで設定した"分"を格納する変数
    @Published var minSelection: Int = 0
    
    // タスク開始可能時間（時間）
    @Published var startHourSelection: Int = 0
    // タスク開始可能時間（分）
    @Published var startMinSelection: Int = 0
    
    
    // MARK: - Timer関連
    // 残り時間
    @Published var duration: Double = 0
    
    // タスクの実行時間
    @Published var runtime: Double = 0
    
    // タスクの目標時間
    @Published var taskTime: Double = 0
    
    // 開始可能時間
    @Published var startableTime: Date = Date()
    @Published var finDate: Date = Date()
    @Published var progressMins: Int = 0
    @Published var notificateNum: Int = 0
    
    // 今の日時
    @Published var nowDate: Date = Date()
    @Published var todayDC = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
    
    //設定した時間が1時間以上、1時間未満1分以上、1分未満1秒以上によって変わる時間表示形式
    @Published var displayedTimeFormat: TimeFormat = .min
    
    //タイマーのステータス
    @Published var timerStatus: TimerStatus = .stopped
    
    //1秒ごとに発動するTimerクラスのpublishメソッド
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // タップした時に表示されるタイマー
    @Published var updatedTimer: String = ""
    
    // タイマー表示の自動更新
    @Published var autoRefreshFlag: Bool = true
    
    // タイマー画面でタスク名を表示する
    @Published var showTaskFlag: Bool = true
    
    
    // MARK: - UI関連
    // 設定画面を一度だけ表示
    @Published var showSettingView: Bool = false
    
    //　タスク名
    @Published var task: String = ""
    
    
    // MARK: - データ保存関連
    @Published var tasks: [TaskMetaData] = []
    
    // 「バックグラウンドへ行くたび」? or 「TaskViewを閉じるたび」 or 「アプリを開いている間に日を跨いだ場合」 にデータを保存
    func saveUserData() {
                 
        if tasks.count != 0 {
            let lastdayDC = Calendar.current.dateComponents([.year, .month, .day], from: tasks[tasks.count - 1].taskDate)
            let todayDC = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            
            // 同じ日のデータは上書き保存
            if lastdayDC.day == todayDC.day {
                /// usedTimeDataが上書きされないようにするために、データを分割して保存する。
                tasks[tasks.count - 1].task = [Task(title: task)]
                tasks[tasks.count - 1].duration = duration
                tasks[tasks.count - 1].runtime = runtime
                tasks[tasks.count - 1].taskDate = Date()
                
            // 違う日のデータは、前日のruntimeを更新したのち、durationとruntimeを初期化し、新しくtasksに追加する
            } else {
                // 前日のデータを更新
                tasks[tasks.count - 1].runtime = runtime
                //tasks[tasks.count - 1].usedTimeData.append(UsedTimeData(title: "running_timer"))
                print("⏬saveUserData()　日付が変わったため、tasksを更新 \(tasks)")
                
                // 変数を初期化
                duration = taskTime
                runtime = 0
                
                // 新しく初期化されたデータを追加保存
                let data = TaskMetaData(
                    task: [
                        Task(title: task)
                    ],
                    duration: duration,
                    runtime: runtime,
                    taskDate: Date(),
                    usedTimeData: [
                        UsedTimeData(title: "")
                    ])

                // 初期化されたデータを追加
                tasks.append(data)

            }
            
        } else {
            
            let data = TaskMetaData(
                task: [
                    Task(title: task)
                ],
                duration: taskTime,
                runtime: 0,
                taskDate: Date(),
                usedTimeData: [
                    UsedTimeData(title: "")
                ])
            // はじめの一つは必ず保存
            tasks.append(data)
            print("😭saveUserData() データが空でした！！！")
        }
        
        //　tasks保存
        saveTasks(tasks: tasks)
        
        // 自動再生モードFlagを保存
        UserDefaults.standard.set(autoRefreshFlag, forKey: "autoRefreshFlag")
        // タスク表示 or 非表示
        UserDefaults.standard.set(showTaskFlag, forKey: "showTaskFlag")
        
        // キャラクター経験値
        UserDefaults.standard.set(expTime, forKey: "expTime")
        
        // Widget用のデータを保存
        let userDefaults = UserDefaults(suiteName: "group.myproject.cLockTimer.myWidget")
        if let userDefaults = userDefaults {
            userDefaults.synchronize()
            // 育成中キャラクター名
            userDefaults.setValue(selectedCharacter, forKey: "selectedCharacter")
            // 育成中キャラクターの画像名
            userDefaults.setValue(selectedCharacterImageName, forKey: "selectedCharacterImageName")
        }
        
        WidgetCenter.shared.reloadAllTimelines()

        // 育成中キャラクター名
        UserDefaults.standard.set(selectedCharacter, forKey: "selectedCharacter")
        // 育成中キャラクターの画像名
        UserDefaults.standard.set(selectedCharacterImageName, forKey: "selectedCharacterImageName")
        // 所持キャラクターリスト
        UserDefaults.standard.set(possessionList, forKey: "possessionList3")
        
        // 今週のデータを更新
        loadWeeklyDashboardData()

        print("😄👍: saved user data!")
        //print("😄👍: saved user data! duration: \(duration) tasks: \(tasks)")
    }
    
    // タスクを設定したタイミングで保存（半永久保存データ）
    func saveCoreData() {
        UserDefaults.standard.set(task, forKey: "task")
        UserDefaults.standard.set(showSettingView, forKey: "showSettingView")
        UserDefaults.standard.set(taskTime, forKey: "taskTime")
        UserDefaults.standard.set(startHourSelection, forKey: "startHourSelection")
        UserDefaults.standard.set(startMinSelection, forKey: "startMinSelection")
        print("😄👍: saved core data")
    }
    
    //
    func loadCoreData() {
        task = UserDefaults.standard.string(forKey: "task") ?? "My TASK"
        autoRefreshFlag = UserDefaults.standard.bool(forKey: "autoRefreshFlag")
        showTaskFlag = UserDefaults.standard.bool(forKey: "showTaskFlag")
        taskTime = UserDefaults.standard.double(forKey: "taskTime")
        startHourSelection = UserDefaults.standard.integer(forKey: "startHourSelection")
        startMinSelection = UserDefaults.standard.integer(forKey: "startMinSelection")
        
        print("😄👍: loaded core data")
    }
    
    // UserDefaultsに保存したデータを呼び出す　アプリが立ち上がったタイミングでのみ実行
    func loadAllData() {
        // もしbackupにデータが残っていた場合、上書き保存する
        //tasks = loadTasks() ?? []
        tasks = loadTasks() ?? loadBackupTasks() ?? []
        
        // キャラクター経験値
        expTime = UserDefaults.standard.double(forKey: "expTime")
        // 育成中キャラクター名
        selectedCharacter = UserDefaults.standard.string(forKey: "selectedCharacter") ?? "Frog"
        // 育成中キャラクターの画像名
        selectedCharacterImageName = UserDefaults.standard.string(forKey: "selectedCharacterImageName") ?? ""
        // 所持キャラクターリスト
        possessionList = UserDefaults.standard.posses
        
        if tasks.count == 0 {
            
            // tasksが空の時にタスク設定画面を表示
            showSettingView = true
            
        } else {
            showSettingView = UserDefaults.standard.bool(forKey: "showSettingView")
            // tasksが空じゃなかった場合のみバックアップを保存する
            saveBackupTasks(tasks: tasks)
        }
        
        // 毎日データが更新されないもの
        loadCoreData()
        
        // 毎日カウントをリセットするもの
        if tasks.count != 0 {
            
            let lastdayDC = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: tasks[tasks.count - 1].taskDate)
            let todayDC = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
            
            // tasksにすでにデータが保存されている & tasksに最後に保存した日が今日　の場合上書き保存
            if lastdayDC.day == todayDC.day {
                // 上書き
                duration = tasks[tasks.count - 1].duration
                runtime = tasks[tasks.count - 1].runtime
                print("loadAllData() データを上書きしました。")
                
            // ロードしたタイミングで日付が変わっていた場合
            } else {
                // 初期化されたデータを追加
                let data = TaskMetaData(
                    task: [
                        Task(title: task)
                    ],
                    duration: taskTime,
                    runtime: 0,
                    taskDate: Date(),
                    usedTimeData: [
                        UsedTimeData(title: "")
                    ])
                tasks.append(data)

                duration = taskTime
                runtime = 0
                
                print("loadAllData() 日付が変わったのでデータを更新しました \(tasks) \(selectedCharacter)")
            }
            
        } else {
            
            let data = TaskMetaData(
                task: [
                    Task(title: task)
                ],
                duration: taskTime,
                runtime: 0,
                taskDate: Date(),
                usedTimeData: [
                    UsedTimeData(title: "")
                ])
            
            // はじめの一つは必ず保存
            tasks.append(data)

            print("😭loadAllData() データが空でした！！！")
        }
        
        // タスク開始可能時間を更新
        setStartableTime()
        //print("😄👍: loaded all data! duration: \(duration) runtime: \(runtime) showSettingView: \(showSettingView) taskTime: \(taskTime)")
    }
    
    // tasksの保存
    func saveTasks(tasks: [TaskMetaData]) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(tasks) else {
            print("😭: tasksの保存に失敗しました。")
            return
        }
        UserDefaults.standard.set(data, forKey: "tasks")
        print("😄👍: tasksの保存に成功しました。")
    }
    
    // tasksの呼び出し
    func loadTasks() -> [TaskMetaData]? {
        let jsonDecoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "tasks"),
              let tasks = try? jsonDecoder.decode([TaskMetaData].self, from: data) else {
            print("😭: tasksのロードに失敗しました。")
            return nil
        }
        print("😄👍: tasksのロードに成功しました。")
        return tasks
    }
    
    // MARK: - tasksのバックアップを保存
    // tasksのバックアップを保存
    func saveBackupTasks(tasks: [TaskMetaData]) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(tasks) else {
            print("😭: tasksBackupの保存に失敗しました。")
            return
        }
        UserDefaults.standard.set(data, forKey: "tasksBackup")
        print("😄👍: tasksBackupの保存に成功しました。")
    }
    
    // tasksのBackupの呼び出し
    func loadBackupTasks() -> [TaskMetaData]? {
        let jsonDecoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "tasksBackup"),
              let backupTasks = try? jsonDecoder.decode([BackupTaskMetaData].self, from: data) else {
            print("🌋😭: tasksBackupのロードに失敗しました。")
            return nil
        }
        var newTasks: [TaskMetaData] = []
        for num in 0..<backupTasks.count {
            let data = TaskMetaData(task: backupTasks[num].task, duration: backupTasks[num].duration, runtime: backupTasks[num].runtime, taskDate: backupTasks[num].taskDate, usedTimeData: [UsedTimeData(title: "")])
            newTasks.append(data)
        }
        print("🌋👍: tasksBackupのロードに成功しました。\(newTasks)")
        return newTasks
    }
    
    // 全てのUserDefaultsを削除する
    func removeAllUserDefaults() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!) //一括削除
        print("removed all userdefaults data")
    }
    
    
    // MARK: - Timer関連
    // タスクの再設定を行う際に、Pickerの項目をリセット
    func resetPicker() {
        hourSelection = 1
        minSelection = 0
        // タスク開始可能時間を現在の時間に合わせる（hourのみ）
        if todayDC.hour! <= 23 {
            startHourSelection = todayDC.hour! + 1
        } else {
            startHourSelection = 0
        }
        startMinSelection = 0
        print("resetPicker()")
    }
    
    // タスクを再設定した後、タイマーをセットする
    func setTimer() {
        // タスクの目標実行時間
        taskTime = Double(hourSelection * 3600 + minSelection * 60)
        
        //残り時間をタスク時間からタスク実行済み時間をひく
        duration = taskTime - runtime
        
        // タスク開始可能時間を更新
        setStartableTime()
        
        // タイマー表示形式を更新
        setDistlayedTimeFormat()
        
        print("setTimer() called")
    }
    
    // 開始可能時間を自動で設定
    func setStartableTime() {
        getTime()
        
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        
        // タスク開始可能時刻の設定
        startableTime = calendar.date(from: DateComponents(year: todayDC.year, month: todayDC.month, day: todayDC.day, hour: 9+startHourSelection, minute: startMinSelection)) ?? today
        
        // 現在から今日の深夜までの残り分
        progressMins = calendar.dateComponents([.minute], from: nowDate, to: finDate).minute!
        
        // 現在から今日の深夜までの残り分を5で割った数　→ 五分毎の通知を鳴らすためのパラメータ
        notificateNum = Int(progressMins / 5)
        
        print("startable time \(startableTime)\n finday: \(finDate)\n progressMins: \(progressMins)\n \(nowDate)")
    }
    
    // nowDate, finDate を更新
    func getTime() {
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        todayDC = Calendar.current.dateComponents([.year, .month, .day, .hour], from: today)
        
        // 現在の時間
        nowDate = returnNowDate()
        // 今日の夜12時
        finDate = calendar.date(from: DateComponents(year: todayDC.year, month: todayDC.month, day: todayDC.day, hour: 9+24, minute: 0))!

        print("getTime() nowDate: \(nowDate) finDate: \(finDate)")
    }
    
    func returnNowDate() -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let today = Date()
        
        // 現在の時間
        nowDate = calendar.date(byAdding: .hour, value: 9, to: today)!
        print("returnNowDate() \(nowDate)")
        return nowDate
    }
    
    func setDistlayedTimeFormat() {
        //60秒未満なら00形式、60秒以上3600秒未満なら00:00形式、3600秒以上なら00:00:00形式
        if duration < 60 {
            displayedTimeFormat = .sec
        } else if duration < 3600 {
            displayedTimeFormat = .min
        } else {
            displayedTimeFormat = .hr
        }
        
        print("setDistlayedTimeFormat()")
    }
    
    // runtimeを文字列に変換しカレンダーへ表示する
    func runtimeToString(time: Double, second: Bool) -> String {
        //残り時間（時間単位）= 残り合計時間（秒）/3600秒
        let hr = Int(time) / 3600
        //残り時間（分単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒
        let min = Int(time) % 3600 / 60
        //残り時間（秒単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒 で割った余り
        let sec = Int(time) % 3600 % 60
        
        if second {
            return String(format: "%02d:%02d:%02d", hr, min, sec)

        } else {
            return String(format: "%02d:%02d", hr, min)
            
        }
    }
    
    //カウントダウン自動更新ON
    func displayTimer() -> String {
        if timerStatus == .stopped {
            return "Finish!"
            
        } else if timerStatus == .excess {
            let excessTime = runtime - taskTime
            //残り時間（時間単位）= 残り合計時間（秒）/3600秒
            let hr = Int(excessTime) / 3600
            //残り時間（分単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒
            let min = Int(excessTime) % 3600 / 60
            //残り時間（秒単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒 で割った余り
            let sec = Int(excessTime) % 3600 % 60
            
            //print(Int(duration))
            //setTimerメソッドの結果によって時間表示形式を条件分岐し、上の3つの定数を組み合わせて反映
            switch displayedTimeFormat {
            case .hr:
                return String(format: "+%02d:%02d:%02d", hr, min, sec)
            case .min:
                return String(format: "+%02d:%02d:%02d", hr, min, sec)
            case .sec:
                return String(format: "+%02d:%02d:%02d", hr, min, sec)
            }
            
        } else {
            //残り時間（時間単位）= 残り合計時間（秒）/3600秒
            let hr = Int(duration) / 3600
            //残り時間（分単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒
            let min = Int(duration) % 3600 / 60
            //残り時間（秒単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒 で割った余り
            let sec = Int(duration) % 3600 % 60
            
            //print(Int(duration))
            //setTimerメソッドの結果によって時間表示形式を条件分岐し、上の3つの定数を組み合わせて反映
            switch displayedTimeFormat {
            case .hr:
                return String(format: "%02d:%02d:%02d", hr, min, sec)
            case .min:
                return String(format: "%02d:%02d", min, sec)
            case .sec:
                return String(format: "%02d:%02d", min, sec)
            }
        }
    }
    
    // 自動更新OFF
    func updateTimer() {
        setDistlayedTimeFormat()
        
        if timerStatus == .stopped {
            updatedTimer = "Finish!"
            
        } else if timerStatus == .excess {
            let excessTime = runtime - taskTime
            //残り時間（時間単位）= 残り合計時間（秒）/3600秒
            let hr = Int(excessTime) / 3600
            //残り時間（分単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒
            let min = Int(excessTime) % 3600 / 60
            //残り時間（秒単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒 で割った余り
            let sec = Int(excessTime) % 3600 % 60
            
            //setTimerメソッドの結果によって時間表示形式を条件分岐し、上の3つの定数を組み合わせて反映
            switch displayedTimeFormat {
            case .hr:
                updatedTimer = String(format: "+%02d:%02d:%02d", hr, min, sec)
            case .min:
                updatedTimer = String(format: "+%02d:%02d:%02d", hr, min, sec)
            case .sec:
                updatedTimer = String(format: "+%02d:%02d:%02d", hr, min, sec)
            }
            
        } else {
            //残り時間（時間単位）= 残り合計時間（秒）/3600秒
            let hr = Int(duration) / 3600
            //残り時間（分単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒
            let min = Int(duration) % 3600 / 60
            //残り時間（秒単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒 で割った余り
            let sec = Int(duration) % 3600 % 60
            
            //setTimerメソッドの結果によって時間表示形式を条件分岐し、上の3つの定数を組み合わせて反映
            switch displayedTimeFormat {
            case .hr:
                updatedTimer = String(format: "%02d:%02d:%02d", hr, min, sec)
            case .min:
                updatedTimer = String(format: "%02d:%02d", min, sec)
            case .sec:
                updatedTimer = String(format: "%02d:%02d", min, sec)
            }
        }
    }
    
    //スタート
    func start() {
        //タイマーステータスを.runningにする
        timerStatus = .running
    }
    
    //一時停止
    func pause() {
        //タイマーステータスを.pauseにする
        timerStatus = .pause
    }
    
    
    // MARK: - 通知関連
    func setNotification() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
            (granted, _) in
            if granted {
                //許可
                self.makeNotification()
            }else{
                //非許可
            }
        }
    }
    
    // 通知を作成
    func makeNotification() {
        //setStartableTime()
        
        print("makeNotification()  nowDate: \(nowDate) startableTime: \(startableTime)")
        if nowDate > startableTime && runtime < taskTime {
            // バックグラウンド状態になったタイミングで通知
            makeBackgroundNotification()

            for num in 0..<notificateNum {
                let notificationIdentifier = String(num)
                let notificationDate = nowDate.addingTimeInterval(TimeInterval(num * 5 * 60))
                let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)
                
                //日時でトリガー指定
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                
                //通知内容
                let content = UNMutableNotificationContent()
                content.title = "タスク開始可能時間を迎えました。"
                content.body  = "設定したタスクに取り掛かりましょう。"
                content.sound = UNNotificationSound.default
                
                //リクエスト作成
                let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
                
                //通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                //print("Notification added! identifer: \(notificationIdentifier) Date: \(notificationDate)")
            }
        }
        
        // 毎朝8時に通知を行う
        makeAlldayNotification()
    }
    
    // 毎朝8時に通知を行う
    func makeAlldayNotification() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        let alldayNotificationIdentifier = "allDayNotification"
        let today = Date()
        let todayDC = Calendar.current.dateComponents([.year, .month, .day], from: today)
        let alldayNotificationDate = calendar.date(from: DateComponents(year: todayDC.year, month: todayDC.month, day: todayDC.day! + 1, hour: 8, minute: 0))
        let alldayDateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: alldayNotificationDate!)
        //日時でトリガー指定
        let alldayTrigger = UNCalendarNotificationTrigger(dateMatching: alldayDateComp, repeats: false)
        
        //通知内容
        let content = UNMutableNotificationContent()
        content.title = "おはようございます"
        content.body  = "今日のタスクを設定しましょう。"
        content.sound = UNNotificationSound.default
        
        //リクエスト作成
        let request = UNNotificationRequest(identifier: alldayNotificationIdentifier, content: content, trigger: alldayTrigger)
        
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("Allday Notification added! identifer: \(alldayNotificationIdentifier) Date: \(alldayNotificationDate!)")
    }
    
    // バックグラウンドへ行ったタイミングでの通知
    func makeBackgroundNotification() {
        let notificationIdentifier = "backgroundNotification"
        let notificationDate = nowDate.addingTimeInterval(TimeInterval(1))
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)
        
        //日時でトリガー指定
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        
        //通知内容
        let content = UNMutableNotificationContent()
        content.title = "バックグラウンド通知を設定しました"
        content.body  = "設定したタスクに取り掛かりましょう。"
        content.sound = UNNotificationSound.default
        
        //リクエスト作成
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        //通知をセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        print("Background Notification added! identifer: \(notificationIdentifier) Date: \(notificationDate)")
    }
    
    // 登録された通知を全て削除
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        print("All notifications are removed")
    }
    
    
    // MARK: - 今週１週間のデータをまとめる

    @Published var thisWeekRuntimeList: [Double] = [0, 0, 0, 0, 0, 0, 0]
    @Published var todayNum: Int = 0
    @Published var thisWeekRuntimeSum: Double = 0

    func loadThisWeekData() {
        thisWeekRuntimeList = [0, 0, 0, 0, 0, 0, 0]
        thisWeekRuntimeSum = 0
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        let today = Date()
        let thisWeekNum = calendar.component(.weekOfYear, from: today)
        todayNum = Int(calendar.component(.weekday, from: today)) - 1
        
        if tasks.count != 0 {
            for num in 0..<tasks.count {
                let day = self.tasks[num].taskDate
                let dayRuntime = self.tasks[num].runtime
                let dayWeekNum = calendar.component(.weekOfYear, from: day)
                let daysNum = Int(calendar.component(.weekday, from: day)) // ex) 月曜日: 2
                if thisWeekNum == dayWeekNum {
                    self.thisWeekRuntimeList[daysNum - 1] = dayRuntime
                    self.thisWeekRuntimeSum += dayRuntime
                }
                
            }
        }
        print("loadThisWeekData() thisWeekRuntimeList: \(thisWeekRuntimeList) thisWeekRuntimeSum: \(thisWeekRuntimeSum)")
    }
    
    
    // MARK: - 今月のデータをまとめる
    
    // 今月の総タスク実行時間
    @Published var thisMonthRuntimeSum: Double = 0

    func loadThisMonthData() {
        thisMonthRuntimeSum = 0
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        let today = Date()
        let thisYearNum  = calendar.component(.year, from: today)
        let thisMonthNum = calendar.component(.month, from: today)
        
        if tasks.count != 0 {
            for num in 0..<tasks.count {
                let day = self.tasks[num].taskDate
                let dayRuntime = self.tasks[num].runtime
                let dayYearNum = calendar.component(.year, from: day)
                let dayMonthNum = calendar.component(.month, from: day)
                if thisYearNum == dayYearNum && thisMonthNum == dayMonthNum {
                    thisMonthRuntimeSum += dayRuntime
                    //print("\(thisYearNum) \(dayYearNum)  \(thisMonthNum) \(dayMonthNum)")
                }
            }
        }
        
        print("loadThisMonthData() thisMonthRuntimeSum: \(thisMonthRuntimeSum)")
    }
    
    // MARK: - 今までの全てのデータをまとめる
    
    // 今までの総タスク実行時間
    @Published var runtimeEverSum: Double = 0
    
    // 自己ベスト　連続日数
    @Published var maxConsecutiveDays: Int = 1
    
    // 直近の連続日数
    @Published var recentConsecutiveDays: Int = 1
    
    func loadAllEverData() {
        runtimeEverSum = 0

        if tasks.count != 0 {
            for num in 0..<tasks.count {
                let dayRuntime = self.tasks[num].runtime
                runtimeEverSum += dayRuntime
            }
        }
        
        print("loadAllEverData() thisMonthRuntimeSum: \(runtimeEverSum)")
    }
    
    // weekly dashboard用のデータを全てロードする
    func loadWeeklyDashboardData() {
        
        loadThisWeekData()
        loadThisMonthData()
        loadAllEverData()
        
        countMaxConsecutiveDays()
        countRecentConsecutiveDays()
    }
    
    // 今までの最大連続タスク実行日数を数える
    func countMaxConsecutiveDays() {
        maxConsecutiveDays = 1
        var consecutiveDays = 1
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        
        if tasks.count >= 2 {
            for num in 0..<tasks.count - 1 {
                let day = self.tasks[num].taskDate
                let nextDay = self.tasks[num + 1].taskDate
                let dayDay = calendar.component(.day, from: day)
                let nextDayDay = calendar.component(.day, from: nextDay)
                //print("\(num) \(dayDay) \(nextDayDay) \(maxConsecutiveDays) \(consecutiveDays)")
                if nextDayDay - dayDay == 1 {
                    consecutiveDays += 1
                    if consecutiveDays > maxConsecutiveDays {
                        maxConsecutiveDays = consecutiveDays
                    }
                } else {
                    if consecutiveDays > maxConsecutiveDays {
                        maxConsecutiveDays = consecutiveDays
                    }
                    consecutiveDays = 1
                }
            }
        }
        
        print("countMaxConsecutiveDays() maxConsecutiveDays: \(maxConsecutiveDays)")
    }
    
    // 現在の連続タスク実行日数を数える
    func countRecentConsecutiveDays() {
        recentConsecutiveDays = 1
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        
        if tasks.count >= 2 {
            for num in 0..<tasks.count - 1 {
                let day     = self.tasks[tasks.count - num - 1].taskDate
                let prevDay = self.tasks[tasks.count - num - 2].taskDate
                let dayDay     = calendar.component(.day, from: day)
                let prevDayDay = calendar.component(.day, from: prevDay)
                
                if dayDay - prevDayDay == 1 {
                    recentConsecutiveDays += 1
                } else {
                    break
                }
            }
        }
        
        print("countRecentConsecutiveDays() recentConsecutiveDays: \(recentConsecutiveDays)")
    }
    

    // MARK: - Time Calendar View
    // title -> "using_app" or "running_timer" or ""
    // onAppear と onDisappear のタイミングで実行
    func saveTimeCalendarData(title: String) {
        if tasks.count != 0 {
            
            let data = UsedTimeData(title: title)
            // データ追加
            //tasks[tasks.count - 1].usedTimeData.append(data)
            //print("saveTimeCalendarData() tasks: \(tasks)")

        }
        
        // 確認用
//        for num in 0..<tasks.count {
//            let usedDate = self.tasks[num].usedTimeData
//            print("\(tasks[num].taskDate)")
//            for num2 in 0..<usedDate.count {
//                let usedDateDetail = usedDate[num2]
//                print("------\(usedDateDetail)")
//            }
//        }
        
    }
        
    // usedTimeList型からAppointment型へ変換する
    func loadTimeCalendarView(date: Date) -> [Appointment] {
        var usedTimeList: [Appointment] = []
        
        for num in 0..<tasks.count {
            // dayコンポーネントを作成
            let usedDateDay = Calendar.current.dateComponents([.day], from: self.tasks[num].taskDate)
            let dateDay = Calendar.current.dateComponents([.day], from: date)
            // 選択した日付と同じ日のtasksを選択
            if usedDateDay == dateDay {
                let usedDateData = tasks[num].usedTimeData
                // 選択した日付と同じ日のusedTimeDataをusedDateListに格納
                for num2 in 0..<usedDateData.count {
                    let data = Appointment(date: usedDateData[num2].time, message: usedDateData[num2].title)
                    usedTimeList.append(data)
                }
            }
        }
        
        //print("loadTimeCalendarView() usedTimeList: \(usedTimeList)")
        return usedTimeList
    }
    
    // MARK: - 画面制御関連
    // タスク実行バーの色を返す
    func returnRectanglerColor(runtime: Double, opacity: Double) -> Color {
        if runtime <= taskTime * 0.25 {
            return Color(UIColor.red).opacity(opacity)
            
        } else if runtime <= taskTime * 0.5 {
            return Color.red.opacity(opacity)
            
        } else if runtime <= taskTime * 0.75 {
            return Color.orange.opacity(opacity)
            
        } else if runtime <= taskTime {
            return Color(UIColor.orange).opacity(opacity)
            
        } else if runtime <= taskTime * 1.25 {
            return Color.green.opacity(opacity)

        } else if runtime <= taskTime * 1.5 {
            return Color.blue.opacity(opacity)

        } else {
            return Color(UIColor.blue).opacity(opacity)
            
        }
    }
    
    
    
    // MARK: - キャラクター関連

    ///　育成キャラ用
    // キャラクター成長経験値
    @Published var expTime: Double = 0
    // 育成中のキャラクター
    @Published var selectedCharacter: String = ""
    // 育成中のキャラクターの画像の名前
    @Published var selectedCharacterImageName: String = ""
    
    ///　詳細画面で選択された時用
    // 選択中のキャラクターの説明文
    @Published var selectedCharacterDetail: String = ""
    // 選択中のキャラクターの進化形態の数
    @Published var phasesCount: Int = 0
    // 選択中のキャラクターの進化形態の画像のリスト
    @Published var phasesImageList: [String] = []
    // 選択中のキャラクターの進化形態の名前のリスト
    @Published var phasesNameList: [String] = []
    // キャラクターの解放済み形態の保存用リスト
    @Published var possessionList: [String : Int] = [:]
    // 解放済みのキャラクターの初めの卵のリスト　所持済みキャラクター一覧表示用
    @Published var firstEggImageList: [[String]] = []
    
    // 現在育成中のキャラクターのデータを更新する
    // ContentViewのAppear、TaskViewのDisapper, CharacterDetailViewのボタンを押した時に実行
    func loadSelectedCharacterData() {
        // 初めてアプリを開いた時用
        if selectedCharacter == "" || selectedCharacterImageName == "" {
            selectedCharacter = selectCharacter()
        }
        
        guard let character = CharacterData[selectedCharacter] as? [String : Any] else {
            return
        }
        let name = character["Name"] as! String
        let hp = character["HP"] as! Double
        let expRatio = character["ExpRatio"] as! [Double]
        let images = character["Images"] as! [String]
        
        var imageIndex = 0
        
        for num in 0 ..< expRatio.count {
            if expTime > hp * expRatio[num] {
                imageIndex = num + 1
            } else {
                imageIndex = num
                break
            }
        }
                
        // 解放済みリストを更新する
        updatePossessionList(name: name, index: imageIndex)
        // 現在育成中のキャラクターの画像を更新
        selectedCharacterImageName = images[imageIndex]
        
        // 育成中キャラクター名
        UserDefaults.standard.set(selectedCharacter, forKey: "selectedCharacter")
        // 育成中キャラクターの画像名
        UserDefaults.standard.set(selectedCharacterImageName, forKey: "selectedCharacterImageName")

        print("loadSelectedCharacterData() name: \(name) hp: \(hp), expTime: \(expTime), imageIndex: \(imageIndex), キャラクター数: \(CharacterData.count)")
    }
    
    // 詳細画面に表示するデータを更新
    /// userDataViewでキャラクターのアイコンのタップ時、CharacterDetailViewで下の開放済み卵一覧をタップされた時、CharacterDetailViewのボタンをタップされた時
    func loadCharacterDetailData(selectedDetailCharacter: String) {
        var detailCharacter = selectedDetailCharacter
        if detailCharacter == "" {
            detailCharacter = selectedCharacter
        }
        
        guard let character = CharacterData[detailCharacter] as? [String : Any] else {
            return
        }
        let name = character["Name"] as! String
        let images = character["Images"] as! [String]
        let phases = character["PhaseName"] as! [String]
        let detail = character["Detail"] as! String
        // 進化形態の画像のリスト
        phasesImageList = images
        // 進化形態の名前のリスト
        phasesNameList = phases
        // 選択されたキャラクターの詳細
        selectedCharacterDetail = detail
        // phasesCountを更新
        phasesCount = possessionList[name]!
        // firstEggImageListを更新
        firstEggImageList = loadPossessionFirstEgg()
        
        
        print("loadCharacterDetailData() name: \(name), phasesCount: \(phasesCount), possessionList: \(possessionList)")
    }
    
    // 解放済みリストを参照して、解放済みリストを更新する
    func updatePossessionList(name: String, index: Int) {
       
        let characterList = Array(possessionList.keys) as! [String]
        
        // 解放済みリストに含まれていた場合、インデックスの大きい方を保存する
        if characterList.contains(name) {
            if index > possessionList[name]! {
                // [name:index] を追加
                possessionList[name] = index
            }
        // 解放済みリストに含まれなかった場合新しく追加
        } else {
            // [name:index] を追加
            possessionList[name] = index
        }
        // possessionListを保存
        UserDefaults.standard.posses = possessionList
        
    }
    
    // 選択中のキャラクターをリセット
    func selectCharacter() -> String {
        //　ランダムの数値を返す
        let randomInt = Int.random(in: 0...CharacterData.count-1)
        //　CharacterDataのkeyのリストを作成
        let characterList = Array(CharacterData.keys) as! [String]
        //　keyのリストからランダムでキャラクター名を選択
        let characterName = characterList[randomInt]
        
        // 現在選択中のキャラクターを更新
        //selectedCharacter = characterName
        expTime = 0
        
        return characterName
    }
    
    func loadPossessionFirstEgg() -> [[String]]{
        var imageList:[[String]] = []
        let keyArray = Array(possessionList.keys)
        print("keyArray: \(keyArray)")
        
        if possessionList.count != 0 {
            for num in 0 ..< possessionList.count {
                guard let character = CharacterData[keyArray[num]] as? [String : Any] else {
                    print("error")
                    return imageList
                }
                let images: [String] = character["Images"] as! [String]
                
                imageList.append([keyArray[num], images[0]])
            }
        }
        
        return imageList
    }
    
    
    // MARK: - 画面の向きを検知
//    @Published var currentDeviceOrientation: String = ""
//    @Published var prevDeviceOrientation: String = ""
//    @Published var detectPaddingByOrientation: Bool = false
//    private var orientationObserver: NSObjectProtocol? = nil
//    let notification = UIDevice.orientationDidChangeNotification
//
//    func startDetectOrientation() {
//        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
//        orientationObserver = NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) {
//            [weak self] _ in
//            switch UIDevice.current.orientation {
//            case .faceUp:
//                self?.currentDeviceOrientation = "Face Up"
//            case .faceDown:
//                self?.currentDeviceOrientation = "Face Down"
//            case .portrait:
//                self?.currentDeviceOrientation = "Portrait"
//            case .portraitUpsideDown:
//                self?.currentDeviceOrientation = "Portrait Upside Down"
//            case .landscapeRight:
//                self?.currentDeviceOrientation = "Landscape Right"
//            case .landscapeLeft:
//                self?.currentDeviceOrientation = "Landscape Left"
//            case .unknown:
//                self?.currentDeviceOrientation = "Unknown"
//            default:
//                break
//
//            }
//        }
//    }
//
//    func detectPortrait() {
//        if self.currentDeviceOrientation == "Portrait" || self.currentDeviceOrientation == "Portrait Upside Down" {
//
//            //prevDeviceOrientation = currentDeviceOrientation
//            print("A")
//            detectPaddingByOrientation = true
//
//        } else if self.currentDeviceOrientation == "Landscape Right" || self.currentDeviceOrientation == "Landscape Left" {
//
//            //prevDeviceOrientation = currentDeviceOrientation
//            print("B")
//            detectPaddingByOrientation = false
//
//        }
//    }
//
//    func stopDetectOrientation() {
//        if let orientationObserver = orientationObserver {
//            NotificationCenter.default.removeObserver(orientationObserver, name: notification, object: nil)
//        }
//        orientationObserver = nil
//        UIDevice.current.endGeneratingDeviceOrientationNotifications()
//    }
//
//    deinit {
//        stopDetectOrientation()
//    }
}

extension UserDefaults {
    
    var posses: [String: Int] {
        get {
            guard let areas = object(forKey: "possessionList3") as? [String: Int] else { return [:] }
            return areas
        }
        set {
            set(newValue, forKey: "possessionList3")
        }
    }
}
