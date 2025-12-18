# ⚡ Railway Quick Deploy Guide

## ✅ Error Fixed!

File konfigurasi Railway sudah LENGKAP di folder `/backend`:
- ✅ Procfile
- ✅ railway.toml  
- ✅ nixpacks.toml
- ✅ requirements.txt

---

## 🚀 3 Langkah Deploy:

### 1. Push ke GitHub
```bash
git add .
git commit -m "Add Railway config"
git push origin main
```

### 2. Deploy di Railway

**Railway Settings:**
```
Root Directory: /backend  ⚠️ PENTING!
```

**Environment Variables:**
```
MONGO_URL=mongodb+srv://username:password@cluster.mongodb.net/
DB_NAME=bin_bimbel
CORS_ORIGINS=*
```

### 3. Setup MongoDB Atlas

1. https://mongodb.com/atlas
2. Create FREE cluster
3. Get connection string
4. Paste ke MONGO_URL di Railway

---

## ❌ Troubleshooting

**"Script start.sh not found"**
→ Set Root Directory = `/backend` di Railway settings

**"Could not build"**
→ Pastikan file sudah di-push ke GitHub

**"Connection refused"**
→ Check MongoDB connection string & IP whitelist (0.0.0.0/0)

---

## 🎯 Result

Setelah deploy sukses:
```
URL: https://your-app.up.railway.app
Test: https://your-app.up.railway.app/api/
```

Expected response:
```json
{
  "message": "BIN Bimbel API - Ready"
}
```

---

**📖 Panduan lengkap:** `CARA_DEPLOY_RAILWAY.md`
