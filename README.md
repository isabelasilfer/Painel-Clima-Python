## 🗄️ Estrutura de Dados

O projeto utiliza um modelo relacional para garantir que as medições sejam organizadas por localidade e tipo de clima.

### Modelagem do Banco:
- **Local**: Armazena latitude, longitude e timezone.
- **Clima**: Tabela de referência para códigos WMO e descrições.
- **Medição**: Registro temporal contendo temperatura e velocidade do vento.


### Como usar o Banco de Dados:
1. Para uso local (SQLite), basta executar `python dados.py`. O arquivo `dadosclima.db` será criado/atualizado automaticamente.
2. Para produção (MySQL), importe o arquivo `BancodeDadosImplementadoDadosClima.sql` no seu servidor.
