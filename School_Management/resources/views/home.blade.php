<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
</head>
<body>
    <form action="{{route('produk.index')}}" method="GET"></form>
    <input type="text" name="keyword" placeholder="cari produk...">
    <button type = "submit"> cari </button>
</body>
</html>