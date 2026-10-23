import {emptyState,validateState} from './domain.js';
const prefix='grao-v3:';
export function readState(scope='local'){const raw=localStorage.getItem(prefix+scope);return raw?validateState(JSON.parse(raw)):emptyState()}
export function writeState(state,scope='local'){validateState(state);state.updatedAt=new Date().toISOString();localStorage.setItem(prefix+scope,JSON.stringify(state))}
export function legacyData(){try{const data=JSON.parse(localStorage.getItem('grao-checklists-v1'));return Array.isArray(data)&&data.length?data:null}catch{return null}}
export function clearState(scope){localStorage.removeItem(prefix+scope)}
export function openFiles(){return new Promise((resolve,reject)=>{const r=indexedDB.open('grao-files',1);r.onupgradeneeded=()=>r.result.createObjectStore('files',{keyPath:'id'});r.onsuccess=()=>resolve(r.result);r.onerror=()=>reject(r.error)})}
export async function putFiles(files){if(!files.length)return [];const db=await openFiles(),records=files.map(f=>({id:crypto.randomUUID(),name:f.name,size:f.size,blob:f}));try{await new Promise((resolve,reject)=>{const tx=db.transaction('files','readwrite');for(const r of records)tx.objectStore('files').put(r);tx.oncomplete=resolve;tx.onerror=()=>reject(tx.error)})}finally{db.close()}return records.map(({id,name,size})=>({id,name,size}))}
export async function getFile(id){const db=await openFiles();try{return await new Promise((resolve,reject)=>{const r=db.transaction('files').objectStore('files').get(id);r.onsuccess=()=>resolve(r.result);r.onerror=()=>reject(r.error)})}finally{db.close()}}
export async function removeFile(id){const db=await openFiles();try{await new Promise((resolve,reject)=>{const tx=db.transaction('files','readwrite');tx.objectStore('files').delete(id);tx.oncomplete=resolve;tx.onerror=()=>reject(tx.error)})}finally{db.close()}}
export async function restoreFiles(records){if(!records.length)return;const db=await openFiles();try{await new Promise((resolve,reject)=>{const tx=db.transaction('files','readwrite');for(const r of records)tx.objectStore('files').put(r);tx.oncomplete=resolve;tx.onerror=()=>reject(tx.error);tx.onabort=()=>reject(tx.error)})}finally{db.close()}}
