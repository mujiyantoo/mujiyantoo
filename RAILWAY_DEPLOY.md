# Railway Deployment Guide - BIN Bimbel

## ✅ File Sudah Siap untuk Railway

File-file berikut sudah dibuat:
- ✅ `start.sh` - Script untuk start backend
- ✅ `railway.toml` - Konfigurasi Railway
- ✅ `nixpacks.toml` - Build configuration
- ✅ `Procfile` - Process configuration
- ✅ `runtime.txt` - Python version
- ✅ `backend/railway.toml` - Backend specific config
- ✅ `.railwayignore` - Ignore frontend

## 🚂 Cara Deploy ke Railway

### Option 1: Deploy Backend Saja (Recommended)

**Step 1: Di Railway Dashboard**
1. New Project → Deploy from GitHub
2. Pilih repository Anda
3. **PENTING:** Set **Root Directory** = `/backend`
4. Railway akan otomatis detect Python app

**Step 2: Set Environment Variables**
Di Railway dashboard, tambahkan variables:
```
MONGO_URL=mongodb+srv://username:password@cluster.mongodb.net/
DB_NAME=bin_bimbel
CORS_ORIGINS=*
PORT=8001
```

**Step 3: Deploy**
- Klik "Deploy"
- Tunggu 5-10 menit
- Dapatkan URL: `https://your-app.up.railway.app`

**Step 4: Update Frontend**
Update `/frontend/.env`:
```
REACT_APP_BACKEND_URL=https://your-app.up.railway.app
```

### Option 2: Deploy Full Project

**Step 1: Di Railway Dashboard**
1. New Project → Deploy from GitHub
2. Pilih repository
3. **Root Directory** = `/` (root)
4. Railway akan gunakan `start.sh`

**Step 2: Environment Variables** (sama seperti di atas)

**Step 3: Deploy**

## 🗄️ Setup MongoDB Atlas (Gratis)

Railway perlu MongoDB eksternal:

1. **Buat Account:** https://mongodb.com/atlas
2. **Buat Cluster:** 
   - Pilih "Shared" (gratis)
   - Provider: AWS
   - Region: Singapore/terdekat
3. **Create Database User:**
   - Username: binbimbel
   - Password: (generate strong password)
4. **Get Connection String:**
   - Connect → Drivers
   - Copy connection string
   - Ganti `<password>` dengan password Anda
5. **Set di Railway:**
   - `MONGO_URL` = connection string MongoDB Atlas

## 🔧 Troubleshooting

### Error: "Could not determine how to build"
✅ FIXED - File `start.sh` dan `railway.toml` sudah dibuat

### Error: "Module not found"
- Pastikan `requirements.txt` ada di `/backend`
- Check Railway logs untuk detail error

### Error: "Connection refused"
- Pastikan MongoDB Atlas IP Whitelist = `0.0.0.0/0` (allow all)
- Verify connection string correct

### Error: "Port already in use"
- Railway otomatis set `$PORT` variable
- Jangan hardcode port di code

## 📊 Setelah Deploy

**Backend URL:** `https://your-app.up.railway.app`

**Test API:**
```bash
curl https://your-app.up.railway.app/api/
```

**Response:**
```json
{
  "message": "BIN Bimbel API - Ready"
}
```

## 💰 Biaya Railway

- **Gratis:** $5 credit/bulan
- **Hobby Plan:** $5/bulan
- Backend API biasanya pakai ~$3-5/bulan

## 🎯 Rekomendasi

**Best Setup:**
- Backend: Railway
- Frontend: Vercel (gratis, unlimited)
- Database: MongoDB Atlas (gratis 512MB)

**Total Cost:** $0-5/bulan

## 📞 Support

Jika ada masalah:
- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
