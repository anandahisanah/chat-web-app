import { createRouter, createWebHistory } from 'vue-router'
import Home from './App.vue'

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: Home,
    },
    {
      path: '/guest',
      component: () => import('./components/guest/Add.vue'),
    },
  ],
})
