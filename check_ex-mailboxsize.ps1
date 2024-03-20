get-mailbox -resultsize unlimited | Get-MailboxStatistics |format-table -Property displayname, totalitemsize -HideTableHeaders
