# API Contracts - BIN Bimbel Website

## Overview
Dokumentasi API endpoints dan integrasi frontend-backend untuk website BIN Bimbel.

---

## Mock Data yang Perlu Diganti
File: `/app/frontend/src/mock.js`

**Data yang di-mock:**
- ✅ `programs` - Tetap di mock (static data)
- ✅ `testimonials` - Tetap di mock (static data)
- ✅ `whyChooseUs` - Tetap di mock (static data)
- ✅ `galleryImages` - Tetap di mock (static data)
- ✅ `contactInfo` - Tetap di mock (static data)
- ❌ **Form submission di PendaftaranPage** - Perlu diganti dengan API call

---

## Backend Implementation

### 1. MongoDB Model

**Collection:** `registrations`

**Schema:**
```python
{
    "_id": ObjectId,
    "nama_lengkap": str (required),
    "nama_panggilan": str,
    "jenis_kelamin": str (required, enum: ["L", "P"]),
    "tempat_lahir": str (required),
    "tanggal_lahir": str (required),
    "asal_sekolah": str (required),
    "kelas": str (required),
    "alamat": str (required),
    "telepon": str (required),
    "email": str,
    
    # Data Orang Tua
    "nama_ayah": str (required),
    "pekerjaan_ayah": str,
    "telepon_ayah": str (required),
    "nama_ibu": str (required),
    "pekerjaan_ibu": str,
    "telepon_ibu": str (required),
    "alamat_ortu": str,
    
    # Program
    "program": str (required),
    "mata_pelajaran": List[str] (required),
    "hari": str (required),
    "waktu": str (required),
    
    # Info Tambahan
    "referensi": str (required),
    "persetujuan": bool (required),
    "tanggal_daftar": str (required),
    
    # Metadata
    "created_at": datetime,
    "updated_at": datetime
}
```

---

## API Endpoints

### Base URL
- Development: `http://localhost:8001/api`
- Production: Dari environment variable `REACT_APP_BACKEND_URL`

---

### 1. POST /api/registrations
**Deskripsi:** Submit formulir pendaftaran siswa baru

**Request Body:**
```json
{
    "nama_lengkap": "Ahmad Fauzi",
    "nama_panggilan": "Fauzi",
    "jenis_kelamin": "L",
    "tempat_lahir": "Tasikmalaya",
    "tanggal_lahir": "2010-05-15",
    "asal_sekolah": "SMPN 1 Tasikmalaya",
    "kelas": "smp9",
    "alamat": "Jl. Merdeka No. 123",
    "telepon": "08123456789",
    "email": "ahmad@email.com",
    
    "nama_ayah": "Budi Santoso",
    "pekerjaan_ayah": "Wiraswasta",
    "telepon_ayah": "08198765432",
    "nama_ibu": "Siti Nurhaliza",
    "pekerjaan_ibu": "Guru",
    "telepon_ibu": "08187654321",
    "alamat_ortu": "",
    
    "program": "reguler",
    "mata_pelajaran": ["Matematika", "IPA", "Bahasa Indonesia"],
    "hari": "senin",
    "waktu": "sore",
    
    "referensi": "teman",
    "persetujuan": true,
    "tanggal_daftar": "2024-01-15"
}
```

**Response Success (201):**
```json
{
    "success": true,
    "message": "Pendaftaran berhasil! Tim kami akan segera menghubungi Anda.",
    "data": {
        "registration_id": "507f1f77bcf86cd799439011",
        "nama_lengkap": "Ahmad Fauzi",
        "program": "reguler",
        "created_at": "2024-01-15T10:30:00Z"
    }
}
```

**Response Error (400):**
```json
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "nama_lengkap": "Field required",
        "telepon": "Invalid phone number format"
    }
}
```

**Response Error (500):**
```json
{
    "success": false,
    "message": "Internal server error"
}
```

---

### 2. GET /api/registrations
**Deskripsi:** Ambil semua data pendaftaran (untuk admin)

**Response Success (200):**
```json
{
    "success": true,
    "count": 10,
    "data": [
        {
            "registration_id": "507f1f77bcf86cd799439011",
            "nama_lengkap": "Ahmad Fauzi",
            "program": "reguler",
            "telepon": "08123456789",
            "created_at": "2024-01-15T10:30:00Z"
        }
    ]
}
```

---

### 3. GET /api/registrations/{id}
**Deskripsi:** Ambil detail satu pendaftaran berdasarkan ID

**Response Success (200):**
```json
{
    "success": true,
    "data": {
        "registration_id": "507f1f77bcf86cd799439011",
        "nama_lengkap": "Ahmad Fauzi",
        ...
        "created_at": "2024-01-15T10:30:00Z"
    }
}
```

**Response Error (404):**
```json
{
    "success": false,
    "message": "Registration not found"
}
```

---

## Frontend Integration

### File yang Perlu Diubah

**1. `/app/frontend/src/pages/PendaftaranPage.jsx`**

**Sebelum (Mock):**
```javascript
const handleSubmit = async (e) => {
    e.preventDefault();
    console.log('Form Data:', formData);
    
    toast({
        title: "Pendaftaran Berhasil!",
        description: "Data Anda telah kami terima.",
    });
};
```

**Sesudah (API Call):**
```javascript
const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
        const response = await axios.post(
            `${process.env.REACT_APP_BACKEND_URL}/api/registrations`,
            formData
        );
        
        if (response.data.success) {
            toast({
                title: "Pendaftaran Berhasil!",
                description: response.data.message,
            });
            // Reset form
        }
    } catch (error) {
        toast({
            title: "Pendaftaran Gagal",
            description: error.response?.data?.message || "Terjadi kesalahan",
            variant: "destructive"
        });
    }
};
```

---

## Backend Files Structure

```
/app/backend/
├── server.py (main FastAPI app)
├── models/
│   └── registration.py (Pydantic models)
├── routes/
│   └── registrations.py (API routes)
└── requirements.txt (dependencies)
```

---

## Testing Checklist

### Backend Testing
- [ ] POST /api/registrations - valid data
- [ ] POST /api/registrations - invalid data
- [ ] POST /api/registrations - missing required fields
- [ ] GET /api/registrations - list all
- [ ] GET /api/registrations/{id} - get by id
- [ ] MongoDB connection test
- [ ] CORS configuration test

### Frontend Testing
- [ ] Form validation sebelum submit
- [ ] Success toast muncul saat berhasil
- [ ] Error toast muncul saat gagal
- [ ] Form reset setelah submit berhasil
- [ ] Loading state saat submit
- [ ] Network error handling

### Integration Testing
- [ ] End-to-end form submission
- [ ] Data tersimpan di MongoDB
- [ ] Response time < 2 detik
- [ ] Mobile responsive form

---

## Environment Variables

**Backend (.env):**
```
MONGO_URL=mongodb://localhost:27017/
DB_NAME=bin_bimbel
```

**Frontend (.env):**
```
REACT_APP_BACKEND_URL=http://localhost:8001
```

---

## Notes
- Semua data static (programs, testimonials, dll) tetap menggunakan mock data
- Hanya form pendaftaran yang menggunakan backend API
- Implementasi admin dashboard untuk melihat pendaftaran (opsional, future)
