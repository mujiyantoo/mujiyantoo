# 🚂 CARA DEPLOY KE RAILWAY - STEP BY STEP

## ❌ ERROR: "Script start.sh not found"

### ✅ SOLUSI: Deploy HANYA folder BACKEND

---

## 📋 LANGKAH LENGKAP:

### **STEP 1: Push Code ke GitHub**

1. **Buka VS Code** (dari link Emergent atau VS Code desktop)

2. **Buka Terminal** (Menu: Terminal → New Terminal)

3. **Ketik perintah ini SATU PER SATU:**

```bash
# Check apakah sudah ada git
git status

# Kalau belum init:
git init

# Add semua file
git add .

# Commit
git commit -m "Add Railway backend config"

# Connect ke GitHub (ganti dengan repo Anda)
git remote add origin https://github.com/USERNAME/REPO-NAME.git

# Push ke GitHub
git push -u origin main
```

**PENTING:** Ganti `USERNAME` dan `REPO-NAME` dengan milik Anda!

---

### **STEP 2: Buat Akun Railway**

1. Buka: **https://railway.app**
2. Klik **"Start a New Project"**
3. Login dengan GitHub
4. Berikan akses ke repository

---

### **STEP 3: Deploy Backend di Railway**

1. **New Project** → **Deploy from GitHub repo**

2. **Pilih repository** Anda (bin-bimbel atau nama repo Anda)

3. **⚠️ PENTING - Set Root Directory:**
   - Klik **"Variables"** atau **"Settings"**
   - Cari **"Root Directory"** atau **"Service Root"**
   - Isi dengan: `/backend`
   - Save

4. **Add Environment Variables:**
   Klik tab **"Variables"**, tambahkan:
   
   ```
   MONGO_URL = mongodb+srv://username:password@cluster.mongodb.net/
   DB_NAME = bin_bimbel
   CORS_ORIGINS = *
   ```

5. **Klik "Deploy"**

---

### **STEP 4: Setup MongoDB Atlas (Gratis)**

Railway butuh database eksternal:

1. **Buka:** https://www.mongodb.com/cloud/atlas/register
2. **Sign up** (gratis)
3. **Create Cluster:**
   - Pilih **"Shared"** (FREE)
   - Provider: AWS
   - Region: Singapore (atau terdekat)
   - Cluster Name: BINBimbel
   - Klik **"Create Cluster"**
4. **Create Database User:**
   - Username: `binbimbel`
   - Password: (generate strong password - SIMPAN INI!)
5. **Network Access:**
   - Add IP Address
   - Pilih **"Allow Access from Anywhere"** (0.0.0.0/0)
6. **Get Connection String:**
   - Klik **"Connect"**
   - Pilih **"Connect your application"**
   - Copy connection string
   - Format: `mongodb+srv://binbimbel:<password>@cluster.mongodb.net/`
   - Ganti `<password>` dengan password Anda
7. **Paste di Railway:**
   - Kembali ke Railway
   - Variables → MONGO_URL
   - Paste connection string

---

### **STEP 5: Verify Deployment**

1. **Tunggu 5-10 menit** untuk deployment selesai

2. **Dapatkan URL:**
   - Di Railway dashboard, akan muncul URL
   - Format: `https://your-app.up.railway.app`

3. **Test API:**
   Buka browser, kunjungi:
   ```
   https://your-app.up.railway.app/api/
   ```
   
   Harus muncul:
   ```json
   {
     "message": "BIN Bimbel API - Ready"
   }
   ```

4. **Test API Docs:**
   ```
   https://your-app.up.railway.app/docs
   ```

---

## 🎯 ALTERNATIF: Deploy Tanpa GitHub

Jika tidak mau pakai GitHub:

1. **Download code** dari Emergent
2. **Install Railway CLI:**
   ```bash
   npm install -g @railway/cli
   ```
3. **Login:**
   ```bash
   railway login
   ```
4. **Deploy:**
   ```bash
   cd backend
   railway init
   railway up
   ```

---

## 🐛 TROUBLESHOOTING

### Error: "Could not determine how to build"

**Penyebab:** Railway tidak melihat file config

**Solusi:**
1. Pastikan Anda sudah **push ke GitHub**
2. Di Railway, pastikan **Root Directory = /backend**
3. Check file `Procfile` ada di `/backend/Procfile`

### Error: "Module not found"

**Solusi:**
- Check `requirements.txt` ada di `/backend`
- Railway akan otomatis install dependencies

### Error: "Connection refused" / "Database error"

**Solusi:**
1. Pastikan MongoDB Atlas connection string BENAR
2. Pastikan IP Whitelist = `0.0.0.0/0`
3. Test connection string dengan:
   ```bash
   mongosh "mongodb+srv://username:password@cluster.mongodb.net/"
   ```

### Error: "Port already in use"

**Solusi:**
- Railway otomatis set `$PORT` variable
- Jangan hardcode port di code
- Gunakan: `--port $PORT` (sudah diset di Procfile)

---

## 💰 BIAYA

- **Railway Free Tier:** $5 credit/bulan (cukup untuk backend API)
- **MongoDB Atlas Free:** 512MB storage (gratis selamanya)
- **Total:** $0/bulan (cukup untuk UMKM)

---

## 📞 BANTUAN

Jika masih error:
- Railway Docs: https://docs.railway.app
- Railway Discord: https://discord.gg/railway
- MongoDB Support: https://www.mongodb.com/community/forums

---

## ✅ CHECKLIST

Sebelum deploy, pastikan:
- [ ] Code sudah di push ke GitHub
- [ ] Folder `/backend` punya file: `Procfile`, `requirements.txt`, `railway.toml`
- [ ] MongoDB Atlas cluster sudah dibuat
- [ ] Connection string sudah dicopy
- [ ] Railway root directory = `/backend`
- [ ] Environment variables sudah diset

**Setelah deploy sukses, URL Railway bisa langsung digunakan!**
