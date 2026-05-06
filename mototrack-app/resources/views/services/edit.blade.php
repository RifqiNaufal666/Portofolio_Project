<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotoTrack - Edit Riwayat Servis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/spareparts">MotoTrack System</a>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
        <div class="card-header bg-warning text-dark d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Edit Riwayat Servis</h5>
            <a href="/services" class="btn btn-sm btn-light">Kembali</a>
        </div>
        <div class="card-body">
            <form action="/services/{{ $service->id }}" method="POST">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label class="form-label">Nama Pelanggan</label>
                    <input type="text" name="customer_name" class="form-control" value="{{ $service->customer_name }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Model Motor</label>
                    <input type="text" name="motorcycle_model" class="form-control" value="{{ $service->motorcycle_model }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Sparepart yang Digunakan</label>
                    <select name="sparepart_id" class="form-select" required>
                        @foreach($spareparts as $s)
                            <option value="{{ $s->id }}" @selected($s->id == $service->sparepart_id)>
                                {{ $s->name }} (Stok: {{ $s->stock }})
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Mekanik yang Mengerjakan</label>
                    <select name="mechanic_id" class="form-select" required>
                        <option value="">-- Pilih Mekanik --</option>
                        @foreach($mechanics as $m)
                            <option value="{{ $m->id }}" @selected($m->id == $service->mechanic_id)>
                                {{ $m->name }} ({{ $m->specialization }})
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Jumlah</label>
                        <input type="number" name="quantity" class="form-control" value="{{ $service->quantity }}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tanggal Servis</label>
                        <input type="date" name="service_date" class="form-control" value="{{ $service->service_date }}" required>
                    </div>
                </div>

                <hr>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-warning">Update Riwayat</button>
                    <a href="/services" class="btn btn-outline-secondary">Batal</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>