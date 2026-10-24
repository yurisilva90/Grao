import {build} from 'esbuild';
import {mkdir,copyFile,cp,rm} from 'node:fs/promises';
await rm('dist',{recursive:true,force:true});await mkdir('dist');
await build({entryPoints:['src/app.js'],outfile:'dist/app.js',bundle:true,format:'esm',target:['safari16.4','es2022'],minify:true,sourcemap:false});
for(const name of ['index.html','style.css','agenda.css','sw.js','manifest.webmanifest','icon-g-grain.svg','icon-g-grain-192.png','icon-g-grain-512.png','apple-touch-icon-g-grain.png'])await copyFile(name,'dist/'+name);
await cp('primeira-versao','dist/primeira-versao',{recursive:true});

await cp('mockup-agenda','dist/mockup-agenda',{recursive:true});
