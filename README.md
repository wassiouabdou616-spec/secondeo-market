Stack
Node.js + Express
PostgreSQL 18
JWT + bcrypt
Stripe (paiement préparé)
API REST
Frontend responsive sans framework
PostgreSQL 18 est la version majeure courante et 18.6 est la release mineure actuelle au moment de cette génération.
Installation
Installer Node.js.
Installer PostgreSQL 18.
Créer une base secondeo.
Exécuter db/schema.sql.
Copier .env.example vers .env.
Renseigner DATABASE_URL et JWT_SECRET.
npm install
npm start
Ouvrir http://localhost:3000
Stripe
Renseigner STRIPE_SECRET_KEY et STRIPE_WEBHOOK_SECRET. Le backend crée déjà un PaymentIntent. Pour un vrai paiement, il faut connecter Stripe.js côté frontend et configurer le webhook.
Important
Cette V7 est une base technique de développement, pas un service juridiquement ou opérationnellement prêt à lancer sans configuration. Avant production : stockage cloud des images, modération complète, RGPD/cookies, CGV/CGU, sécurité, emails, remboursements, gestion des litiges et tests.
V8 — Expérience marketplace
Favoris persistants
Profils vendeurs / boutique
Messagerie acheteur-vendeur
Notifications
API de conversations
Interface enrichie
Production
Le stockage réel des photos doit être branché sur un service objet/CDN et les clés privées rester dans l'environnement serveur. Le paiement Stripe doit être finalisé avec Stripe.js et les webhooks avant ouverture au public.
