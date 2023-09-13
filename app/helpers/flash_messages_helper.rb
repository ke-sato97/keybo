module FlashMessagesHelper
  def flash_message_class(message_type)
    case message_type
    when "info"
      "p-4 mb-4 text-sm text-blue-800 rounded-lg bg-blue-50 dark:bg-gray-800 dark:text-blue-400" # 情報メッセージ
    when "danger"
      "p-4 mb-4 text-sm text-red-800 rounded-lg bg-red-50 dark:bg-gray-800 dark:text-red-400" # 警告メッセージ
    when "success"
      "p-4 mb-4 text-sm text-green-800 rounded-lg bg-green-50 dark:bg-gray-800 dark:text-green-400" # 成功メッセージ
    when "warning"
      "p-4 mb-4 text-sm text-yellow-800 rounded-lg bg-yellow-50 dark:bg-gray-800 dark:text-yellow-300" # エラーメッセージ
    else
      "p-4 text-sm text-gray-800 rounded-lg bg-gray-50 dark:bg-gray-800 dark:text-gray-300" # デフォルト（未知のメッセージタイプに適用）
    end
  end
end
