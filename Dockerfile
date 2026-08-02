# 1. Usa uma imagem oficial leve do Node.js
FROM node:20-alpine

# 2. Cria o diretório do app dentro do contêiner
WORKDIR /usr/src/app

# 3. Copia os arquivos de dependências primeiro (otimiza o cache do Docker)
COPY package*.json ./

# 4. Instala as dependências do Express e dos submódulos
RUN npm install

# 5. Copia o restante do código fonte incluindo os submódulos para o diretório de trabalho do contêiner
COPY . .

# 6. Expõe a porta que o Express está configurado para escutar
EXPOSE 3000

# 7. Inicia a aplicação chamando o arquivo server.js diretamente
CMD ["node", "server.js"]
