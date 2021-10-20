/*
From: https://gist.github.com/stummsft/ca08d9ceded892160ed623402371f475
*/

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='tls')
    DROP EVENT session [tls] ON SERVER;
GO

CREATE EVENT SESSION [TLS] ON SERVER 
ADD EVENT sqlsni.trace(),
ADD EVENT sqlsni.sni_trace(
	WHERE (
		[function_name]='Ssl::Handshake' 
		AND [sqlserver].[like_i_sql_unicode_string]([text],N'SNISecurity Handshake Handshake Succeeded.%')))
   
ALTER EVENT SESSION [tls] ON SERVER STATE = START;