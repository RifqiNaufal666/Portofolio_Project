<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MotoTrack - Service Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="#">MotoTrack System</a>
        <div class="navbar-nav">
            <a class="nav-link" href="/spareparts">Stok Sparepart</a>
            <a class="nav-link active" href="/services">Riwayat Servis</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm">
        <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Riwayat Servis Motor</h5>
            <a href="/services/create" class="btn btn-success btn-sm">+ Catat Servis Baru</a>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Tanggal</th>
                        <th>Pelanggan</th>
                        <th>Motor</th>
                        <th>Sparepart</th>
                        <th>Mekanik</th><th>Jumlah</th>
                        <th class="text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($logs as $item)
                        <tr>
                            <td>{{ date('d M Y', strtotime($item->service_date)) }}</td>
                            <td>{{ $item->customer_name }}</td>
                            <td>{{ $item->motorcycle_model }}</td>
                            <td>{{ $item->sparepart->name }}</td>
                            <td>{{ $item->quantity }} pcs</td>
                            <td>{{ $item->mechanic->name ?? 'N/A' }}</td> <td>{{ $item->quantity }} pcs</td>
                            <td class="text-center">
                                <a href="/services/{{ $item->id }}/edit" class="btn btn-warning btn-sm text-white">Edit</a>
                                
                                <form action="/services/{{ $item->id }}" method="POST" class="d-inline">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Hapus riwayat ini?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>