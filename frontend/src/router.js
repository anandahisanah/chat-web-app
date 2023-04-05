import { createRouter, createWebHistory } from 'vue-router'

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: () => import('./components/guest/Add.vue'),
    },
    {
      path: '/:guest_id/room',
      component: () => import('./components/room/Show.vue'),
    },
    {
      path: '/:guest_id/room/add',
      component: () => import('./components/room/Add.vue'),
    },
    {
      path: '/:guest_id/room/:room_id/:room_guest_id/chat',
      component: () => import('./components/chat/Show.vue'),
    },
  ],
})
