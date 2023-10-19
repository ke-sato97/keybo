module FlashMessagesHelper
  def flash_message_class(message_type)
    case message_type
    when 'info'
      'p-4 text-lg text-blue-800 border border-blue-500 bg-blue-100 dark:bg-gray-800 dark:text-blue-400' # 情報メッセージ
    when 'danger'
      'p-4 text-lg text-red-800 border border-red-500 bg-red-100 dark:bg-gray-800 dark:text-red-400' # 警告メッセージ
    when 'success'
      'p-4 text-lg text-green-800 border border-green-500 bg-green-100 dark:bg-gray-800 dark:text-green-400' # 成功メッセージ
    when 'warning'
      'p-4 text-lg text-yellow-800 border border-yellow-500 bg-yellow-100 dark:bg-gray-800 dark:text-yellow-300' # エラーメッセージ
    when 'alert'
      'p-4 text-lg text-red-800 border border-red-500 bg-red-100 dark:bg-gray-800 dark:text-red-400' # 警告メッセージ
    when 'notice'
      'p-4 text-lg text-green-800 border border-green-500 bg-green-100 dark:bg-gray-800 dark:text-green-400' # 成功メッセージ
    else
      'p-4 text-lg text-gray-800 border border-gray-500 bg-gray-100 dark:bg-gray-800 dark:text-gray-300' # デフォルト（未知のメッセージタイプに適用）
    end
  end
end
