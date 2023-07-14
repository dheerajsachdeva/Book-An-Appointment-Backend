

async function testing() {
  const req = await fetch("http://127.0.0.1:3000/api/products/1");
  const res = await req.json();
  return res;
}

async () => {
  const v = await testing();
  console.log(v);
  
};
