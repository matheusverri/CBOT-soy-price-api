# puma.rb

# Define o ambiente padrão para produção
environment 'production'

# Configura o número mínimo e máximo de threads que o Puma deve usar para processar solicitações
threads 1, 2

# Configura o número de processos do worker
workers 2

# Configura o socket para o bind
bind 'tcp://0.0.0.0:4567'

# Define o caminho do diretório da aplicação
directory './'

# Define o caminho do arquivo de log
stdout_redirect './log/puma.stdout.log', './log/puma.stderr.log', true
