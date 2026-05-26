import { getAssetFromKV } from '@cloudflare/kv-asset-handler';

export default {
    async fetch(request, env) {
        return getAssetFromKV(request, env);
    }
};
