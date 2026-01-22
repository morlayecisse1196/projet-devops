# Image Node officielle
FROM node:18-alpine

# Dossier de travail dans le conteneur
WORKDIR /app

# Copier les fichiers package
COPY package*.json ./

# Installer les dépendances
RUN npm install --production

# Copier le reste du code
COPY . .

# Exposer le port (ex: 3000 ou 8080 selon ton serveur)
EXPOSE 3000

# Commande de démarrage
CMD ["node", "server.js"]
