<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotoTrack - Catat Servis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/spareparts">MotoTrack Inventory</a>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Catat Riwayat Servis Baru</h5>
        </div>
        <div class="card-body">
            <form action="/services" method="POST">
                @csrf
                
                <div class="mb-3">
                    <label class="form-label">Nama Pelanggan</label>
                    <input type="text" name="customer_name" class="form-control" placeholder="Contoh: Rifqi" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Model Motor</label>
                    <input type="text" name="motorcycle_model" class="form-control" placeholder="Contoh: ADV 160 / PCX 160" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Pilih Sparepart yang Digunakan</label>
                    <select name="sparepart_id" class="form-select" required>
                        <option value="">-- Pilih Barang --</option>
                        @foreach($spareparts as $s)
                            <option value="{{ $s->id }}">{{ $s->name }} (Tersedia: {{ $s->stock }})</option>
                        @endforeach
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Jumlah Digunakan</label>
                        <input type="number" name="quantity" class="form-control" min="1" value="1" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tanggal Servis</label>
                        <input type="date" name="service_date" class="form-control" value="{{ date('Y-m-d') }}" required>
                    </div>
                </div>

                    <div class="mb-3">
                        <label class="form-label">Pilih Mekanik</label>
                        <select name="mechanic_id" class="form-select" required>
                            <option value="">-- Pilih Mekanik --</option>
                            @foreach($mechanics as $m)
                                <option value="{{ $m->id }}">{{ $m->name }} ({{ $m->specialization }})</option>
                            @endforeach
                        </select>
                    </div>

                <hr>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Simpan Riwayat Servis</button>
                    <a href="/services" class="btn btn-outline-secondary">Kembali</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>