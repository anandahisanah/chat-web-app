<script>
import axios from "axios";
export default {
  data() {
    return {
      loading: false,
      guest: {
        id: this.$router.currentRoute.value.params.guest_id,
        name: null,
      },
      name: {
        alias: "Room Name",
        value: null,
      },
    };
  },
  mounted() {
    this.findGuest();
  },
  methods: {
    findGuest() {
      this.loading = true;
      axios
        .get(`http://localhost:3000/guests/${this.guest.id}`)
        .then((response) => {
          this.loading = false;
          this.guest.name = response.data.name;
        })
        .catch((error) => {
          this.loading = false;
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    async create() {
      this.loading = true;
      axios
        .post("http://localhost:3000/rooms", {
          owner_id: this.guest.id,
          name: this.name.value,
        })
        .then((response) => {
          if (response.data.status == "success") {
            this.loading = false;
            this.createRoomGuest(response.data.room);
          }
        })
        .catch((error) => {
          this.loading = false;
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    async createRoomGuest(room) {
      axios
        .post("http://localhost:3000/room_guests", {
          room_id: room.id,
          guest_id: room.owner_id,
        })
        .then((response) => {
          if (response.data.status == "success") {
            this.loading = false;
            this.$notify({
              type: "success",
              title: "Success",
              message: "Created",
              position: "bottom-right",
            });
            this.$router.push(
              `/${this.guest.id}/room/${response.data.room_guest.room_id}/${response.data.room_guest.id}/chat`
            );
          }
        })
        .catch((error) => {
          this.loading = false;
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
  },
};
</script>
<template>
  <div class="flex justify-center">
    <div class="block max-w-sm rounded-lg bg-white p-6 shadow-lg">
      <p
        class="mb-2 text-xl font-medium leading-tight text-neutral-800"
      >
        Welcome {{ guest.name }}!
      </p>
      <p class="mb-2 text-base text-neutral-600">Create New Room Chat</p>
      <p class="mb-4 text-sm text-base text-neutral-600">You're the owner!</p>
      <el-input
        class="my-3"
        prop="name"
        :disabled="loading"
        v-model="name.value"
        :placeholder="name.alias"
      />
      <button
        type="button"
        class="inline-block rounded border-0 px-6 pt-2.5 pb-2 text-xs font-medium uppercase leading-normal bg-sky-300 hover:bg-sky-400"
        :disabled="!name.value || loading"
        @click="create()"
      >
        Create
      </button>
    </div>
  </div>
</template>
