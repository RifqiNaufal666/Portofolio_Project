<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotoTrack - Edit Sparepart</title>
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
        <div class="card-header bg-warning text-dark d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Edit Data Sparepart</h5>
            <a href="/spareparts" class="btn btn-sm btn-light">Kembali</a>
        </div>
        <div class="card-body">
            <form action="/spareparts/{{ $sparepart->id }}" method="POST">
                @csrf
                @method('PUT') <div class="mb-3">
                    <label class="form-label">Nama Sparepart</label>
                    <input type="text" name="name" class="form-control" value="{{ $sparepart->name }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Stok</label>
                    <input type="number" name="stock" class="form-control" value="{{ $sparepart->stock }}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Harga</label>
                    <div class="input-group">
                        <span class="input-group-text">Rp</span>
                        <input type="number" name="price" class="form-control" value="{{ intval($sparepart->price) }}" required>
                    </div>
                </div>

                <hr>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-warning">Update Data</button>
                    <a href="/spareparts" class="btn btn-outline-secondary">Batal</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>